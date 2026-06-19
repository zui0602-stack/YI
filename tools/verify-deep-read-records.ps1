param(
    [string]$DeepReadDir = "sources/deep-reads"
)

$ErrorActionPreference = "Continue"

$root = (Resolve-Path -LiteralPath (Join-Path $PSScriptRoot "..")).Path
$failures = New-Object System.Collections.Generic.List[string]
$warnings = New-Object System.Collections.Generic.List[string]
$records = New-Object System.Collections.Generic.List[object]

function Add-Failure {
    param([string]$Message)
    $failures.Add($Message) | Out-Null
}

function Add-Warning {
    param([string]$Message)
    $warnings.Add($Message) | Out-Null
}

function Get-FieldValue {
    param(
        [string]$Text,
        [string]$Label
    )
    $pattern = "(?m)^\s*-\s*" + [regex]::Escape($Label) + ":\s*(.*)$"
    $match = [regex]::Match($Text, $pattern)
    if ($match.Success) {
        return $match.Groups[1].Value.Trim()
    }
    return $null
}

function Test-HasValue {
    param([string]$Value)
    if ($null -eq $Value) {
        return $false
    }
    $trimmed = $Value.Trim()
    if ($trimmed.Length -eq 0) {
        return $false
    }
    if ($trimmed -match "^(tbd|todo|unknown|\?|pending)$") {
        return $false
    }
    return $true
}

function Test-TruthValue {
    param([string]$Value)
    if (-not (Test-HasValue $Value)) {
        return $false
    }
    if ($Value -match "^(no|false|0|not yet|pending|blocked|unavailable)$") {
        return $false
    }
    return $true
}

Push-Location $root
try {
    if (-not (Test-Path -LiteralPath $DeepReadDir)) {
        Add-Failure "Deep-read directory not found: $DeepReadDir"
    }
    else {
        $files = @(
            Get-ChildItem -LiteralPath $DeepReadDir -Filter "*.md" -File |
                Where-Object { $_.Name -ne "README.md" } |
                Sort-Object Name
        )

        if ($files.Count -eq 0) {
            Add-Warning "No deep-read records yet. This is acceptable while the forum is unavailable, but it means no per-thread record has been completed."
        }

        $allowedStatuses = @("pending", "opened", "summarized", "specialized", "excluded", "blocked")
        $requiredSourceFields = @("Thread ID", "Category", "URL")
        $requiredTemplateFields = @(
            "Page/API opened successfully",
            "Not a 504/blank/error page",
            "Main post reviewed",
            "Replies reviewed",
            "Images reviewed",
            "Video or attachment checked",
            "Primary topic",
            "Sensitive content",
            "Topic note updated",
            "Safety review done",
            "Status"
        )

        foreach ($file in $files) {
            $text = Get-Content -Raw -Encoding utf8 -LiteralPath $file.FullName
            $relative = Resolve-Path -LiteralPath $file.FullName -Relative
            $threadId = Get-FieldValue -Text $text -Label "Thread ID"
            $category = Get-FieldValue -Text $text -Label "Category"
            $status = Get-FieldValue -Text $text -Label "Status"
            $statusLower = if ($null -eq $status) { "" } else { $status.ToLowerInvariant().Trim() }

            if ($text -notmatch "(?m)^#\s+") {
                Add-Failure "$relative missing markdown title"
            }

            foreach ($label in $requiredTemplateFields) {
                if ($null -eq (Get-FieldValue -Text $text -Label $label)) {
                    Add-Failure "$relative missing field: $label"
                }
            }

            foreach ($label in $requiredSourceFields) {
                $value = Get-FieldValue -Text $text -Label $label
                if (-not (Test-HasValue $value)) {
                    Add-Failure "$relative missing required source value: $label"
                }
            }

            if (-not ($allowedStatuses -contains $statusLower)) {
                Add-Failure "$relative has invalid status: $status"
            }

            if ($statusLower -eq "specialized") {
                $mustBeTrue = @(
                    "Page/API opened successfully",
                    "Not a 504/blank/error page",
                    "Main post reviewed",
                    "Safety review done",
                    "Topic note updated"
                )
                foreach ($label in $mustBeTrue) {
                    $value = Get-FieldValue -Text $text -Label $label
                    if (-not (Test-TruthValue $value)) {
                        Add-Failure "$relative specialized record is not complete: $label"
                    }
                }

                if ($category -match "\b3\b") {
                    $value = Get-FieldValue -Text $text -Label "Category 3 coverage updated"
                    if (-not (Test-TruthValue $value)) {
                        Add-Failure "$relative category 3 specialized record must update category 3 coverage"
                    }
                }

                if ($category -match "\b4\b") {
                    $value = Get-FieldValue -Text $text -Label "Category 4 continuation updated"
                    if (-not (Test-TruthValue $value)) {
                        Add-Failure "$relative category 4 specialized record must update category 4 continuation"
                    }
                }
            }

            if ($statusLower -eq "excluded") {
                $reason = Get-FieldValue -Text $text -Label "Exclusion reason"
                if (-not (Test-HasValue $reason)) {
                    Add-Failure "$relative excluded record needs an exclusion reason"
                }
            }

            $dangerPattern = "real token|real api key|real cookie|private endpoint|admin password|card algorithm source"
            if ($text -match $dangerPattern) {
                Add-Warning "$relative contains sensitive-review keywords; inspect before publishing"
            }

            $records.Add([pscustomobject]@{
                file = $relative
                thread_id = $threadId
                category = $category
                status = $statusLower
            }) | Out-Null
        }
    }

    $ok = ($failures.Count -eq 0)
    $result = [System.Collections.Specialized.OrderedDictionary]::new()
    $result.Add("ok", $ok)
    $result.Add("checked_at", (Get-Date).ToString("s"))
    $result.Add("root", $root)
    $result.Add("deep_read_dir", $DeepReadDir)
    $result.Add("record_count", $records.Count)
    $result.Add("failure_count", $failures.Count)
    $result.Add("warning_count", $warnings.Count)
    $result.Add("records", [object]([object[]]$records.ToArray()))
    $result.Add("failures", [object]([object[]]$failures.ToArray()))
    $result.Add("warnings", [object]([object[]]$warnings.ToArray()))
    $result | ConvertTo-Json -Depth 6

    if (-not $ok) {
        exit 1
    }
}
finally {
    Pop-Location
}

