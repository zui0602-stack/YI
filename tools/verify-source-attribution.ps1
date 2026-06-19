param()

$ErrorActionPreference = "Continue"

$root = (Resolve-Path -LiteralPath (Join-Path $PSScriptRoot "..")).Path
$failures = New-Object System.Collections.Generic.List[string]
$warnings = New-Object System.Collections.Generic.List[string]
$checks = New-Object System.Collections.Generic.List[object]

function Add-Check {
    param(
        [string]$Name,
        [bool]$Ok,
        [string]$Detail = ""
    )
    $checks.Add([pscustomobject]@{
        name = $Name
        ok = $Ok
        detail = $Detail
    }) | Out-Null
    if (-not $Ok) {
        $failures.Add($Name + ": " + $Detail) | Out-Null
    }
}

function Add-Warning {
    param([string]$Message)
    $warnings.Add($Message) | Out-Null
}

function Read-Text {
    param([string]$Path)
    return Get-Content -Raw -Encoding utf8 -LiteralPath (Join-Path $root $Path)
}

Push-Location $root
try {
    $required = @(
        "README.md",
        "docs/source-attribution-policy.md",
        "docs/deep-read-protocol.md",
        "docs/github-publishing-checklist.md",
        "templates/deep-read-note.md",
        "sources/category-3-full-manifest.md",
        "sources/category-4-api-scan.md"
    )
    $missing = @($required | Where-Object { -not (Test-Path -LiteralPath $_) })
    Add-Check -Name "attribution-required-files" -Ok ($missing.Count -eq 0) -Detail (($missing -join ", "))

    if ($missing.Count -eq 0) {
        $readme = Read-Text "README.md"
        $policy = Read-Text "docs/source-attribution-policy.md"
        $template = Read-Text "templates/deep-read-note.md"
        $c3 = Read-Text "sources/category-3-full-manifest.md"

        $sourceUrlsOk = (
            $readme -match "https://bbs\.zdjl\.site/#/thread/category/3" -and
            $policy -match "https://bbs\.zdjl\.site/#/thread/detail/\{thread_id\}"
        )
        Add-Check -Name "source-urls-present" -Ok $sourceUrlsOk -Detail "README and attribution policy should keep category and detail URL formats"

        $templateOk = (
            $template -match "Thread ID:" -and
            $template -match "Category:" -and
            $template -match "URL:" -and
            $template -match "Safety review done:"
        )
        Add-Check -Name "deep-read-template-attribution" -Ok $templateOk -Detail "deep-read template must capture source and safety fields"

        $scopeOk = (
            $c3 -match "309" -and
            $policy.Contains("paused by user request")
        )
        Add-Check -Name "scope-counts-present" -Ok $scopeOk -Detail "category 3 count and category 4 paused scope must be visible"

        $incompleteMarker = 'completion' + '.complete = false'
        $policyOk = (
            $policy.Contains("public-safety-policy") -and
            $policy.Contains("no-full-unauthorized-source") -and
            $policy.Contains("incomplete-status-required") -and
            $policy.Contains($incompleteMarker)
        )
        Add-Check -Name "public-safety-policy" -Ok $policyOk -Detail "policy must document prohibited content and incomplete status rule"
    }

    $deepReadRecords = @()
    if (Test-Path -LiteralPath "sources/deep-reads") {
        $deepReadRecords = @(
            Get-ChildItem -LiteralPath "sources/deep-reads" -Filter "*.md" -File |
                Where-Object { $_.Name -ne "README.md" }
        )
    }
    if ($deepReadRecords.Count -eq 0) {
        Add-Warning "No formal deep-read records yet; attribution will become stricter when records exist."
    }

    $ok = ($failures.Count -eq 0)
    $result = [System.Collections.Specialized.OrderedDictionary]::new()
    $result.Add("ok", $ok)
    $result.Add("checked_at", (Get-Date).ToString("s"))
    $result.Add("root", $root)
    $result.Add("failure_count", $failures.Count)
    $result.Add("warning_count", $warnings.Count)
    $result.Add("checks", [object]([object[]]$checks.ToArray()))
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
