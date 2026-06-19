param(
    [int]$MaxPublicFileMb = 5
)

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

function Get-RelativePath {
    param([string]$Path)
    $resolved = (Resolve-Path -LiteralPath $Path).Path
    if ($resolved.StartsWith($root)) {
        return $resolved.Substring($root.Length).TrimStart("\", "/")
    }
    return $resolved
}

Push-Location $root
try {
    $requiredPublicFiles = @(
        ".github/workflows/verify-learning-library.yml",
        ".github/PULL_REQUEST_TEMPLATE.md",
        ".github/ISSUE_TEMPLATE/config.yml",
        ".github/ISSUE_TEMPLATE/deep-read-batch.md",
        ".github/ISSUE_TEMPLATE/source-attribution-review.md",
        ".github/ISSUE_TEMPLATE/forum-recovery-sync.md",
        ".gitignore",
        "CONTRIBUTING.md",
        "README.md",
        "SECURITY.md",
        "START_HERE.md",
        "virtual_test_flow.md",
        "docs/learned-tutorial-classification.md",
        "docs/github-publishing-checklist.md",
        "docs/github-upload-guide.md",
        "docs/completion-audit.md",
        "docs/current-status-report.md",
        "docs/github-actions-ci.md",
        "docs/progress-dashboard.md",
        "docs/deep-read-protocol.md",
        "docs/category-3-c3-01-deep-read.md",
        "docs/category-3-c3-02-deep-read.md",
        "docs/category-3-c3-03-deep-read.md",
        "docs/category-3-source-00-deep-read.md",
        "docs/source-attribution-policy.md",
        "sources/deep-read-ledger.md",
        "sources/learned-tutorial-classification.json",
        "sources/learned-thread-traceability.json",
        "sources/learning-status.generated.json",
        "sources/study-queue.full.generated.json",
        "sources/study-queue.full.generated.md",
        "sources/study-queue.generated.md",
        "sources/deep-reads/README.md",
        "templates/deep-read-note.md",
        "templates/batch-review-report.md",
        "tools/verify-learning-library.ps1",
        "tools/export-learned-traceability.ps1",
        "tools/export-learning-status.ps1",
        "tools/export-study-queue.ps1",
        "tools/sync-zdjl-forum-browser-fetch.mjs",
        "tools/verify-github-package.ps1",
        "tools/verify-source-attribution.ps1",
        "tools/verify-deep-read-records.ps1"
    )

    $missing = @($requiredPublicFiles | Where-Object { -not (Test-Path -LiteralPath $_) })
    Add-Check -Name "required-public-files" -Ok ($missing.Count -eq 0) -Detail (($missing -join ", "))

    $gitignoreText = if (Test-Path -LiteralPath ".gitignore") { Get-Content -Raw -Encoding utf8 -LiteralPath ".gitignore" } else { "" }
    $ignoreNeeded = @("sources/raw/", "sources/raw-*/", "tmp/", "*.log", "screenshots/", "*.mp4", "*.mov", "*.avi")
    $missingIgnores = @($ignoreNeeded | Where-Object { $gitignoreText -notmatch [regex]::Escape($_) })
    Add-Check -Name "gitignore-public-safety" -Ok ($missingIgnores.Count -eq 0) -Detail (($missingIgnores -join ", "))

    $forbiddenPublishRoots = @(
        "sources/raw",
        "tmp",
        "logs",
        "reports",
        "screenshots"
    )
    $existingForbidden = @()
    foreach ($dir in $forbiddenPublishRoots) {
        if (Test-Path -LiteralPath $dir) {
            $fileCount = @(Get-ChildItem -LiteralPath $dir -Recurse -File -ErrorAction SilentlyContinue).Count
            if ($fileCount -gt 0) {
                $existingForbidden += ($dir + " (" + $fileCount + " files, should stay ignored)")
            }
        }
    }
    if ($existingForbidden.Count -gt 0) {
        Add-Warning ("ignored-local-output exists: " + ($existingForbidden -join "; "))
    }

    $publicRoots = @(".", "docs", "sources", "prompts", "examples", "templates", "tests", "tools")
    $excludePrefixes = @(
        "sources\raw\",
        "tmp\",
        "logs\",
        "reports\",
        "screenshots\",
        ".git\",
        ".agents\",
        ".codex\"
    )
    $publicFiles = New-Object System.Collections.Generic.List[System.IO.FileInfo]
    foreach ($item in Get-ChildItem -LiteralPath "." -Recurse -File -Force) {
        $relative = Get-RelativePath -Path $item.FullName
        $skip = $false
        foreach ($prefix in $excludePrefixes) {
            if ($relative.StartsWith($prefix, [System.StringComparison]::OrdinalIgnoreCase)) {
                $skip = $true
            }
        }
        if ($relative -eq ".gitignore" -or $relative -match "^(CONTRIBUTING|README|SECURITY|START_HERE)\.md$" -or $relative -eq "virtual_test_flow.md" -or $relative -match "^(docs|sources|prompts|examples|templates|tests|tools)\\") {
            if (-not $skip) {
                $publicFiles.Add($item) | Out-Null
            }
        }
        elseif ($relative -match "^\.github\\(workflows|ISSUE_TEMPLATE)\\" -or $relative -eq ".github\PULL_REQUEST_TEMPLATE.md") {
            if (-not $skip) {
                $publicFiles.Add($item) | Out-Null
            }
        }
    }

    $largeFiles = @()
    $maxBytes = $MaxPublicFileMb * 1024 * 1024
    foreach ($file in $publicFiles) {
        $relative = Get-RelativePath -Path $file.FullName
        if ($file.Length -gt $maxBytes) {
            $largeFiles += ($relative + " (" + [math]::Round($file.Length / 1MB, 2) + " MB)")
        }
    }
    Add-Check -Name "public-file-size" -Ok ($largeFiles.Count -eq 0) -Detail (($largeFiles -join ", "))

    $forbiddenPublicExtensions = @(".mp4", ".mov", ".avi", ".zip", ".rar", ".7z", ".apk", ".exe")
    $binaryHits = @()
    foreach ($file in $publicFiles) {
        if ($forbiddenPublicExtensions -contains $file.Extension.ToLowerInvariant()) {
            $binaryHits += (Get-RelativePath -Path $file.FullName)
        }
    }
    Add-Check -Name "public-binary-review" -Ok ($binaryHits.Count -eq 0) -Detail (($binaryHits -join ", "))

    $sensitivePattern = "AKIA[0-9A-Z]{16}|AIza[0-9A-Za-z\-_]{35}|sk-[0-9A-Za-z]{20,}|BEGIN (RSA|OPENSSH|PRIVATE) KEY|password\s*=|token\s*=|cookie\s*=|api[_-]?key\s*="
    $sensitiveHits = @()
    foreach ($file in $publicFiles) {
        if ($file.Extension.ToLowerInvariant() -in @(".md", ".json", ".ps1", ".txt", ".zjs", ".js")) {
            $text = Get-Content -Raw -Encoding utf8 -LiteralPath $file.FullName
            if ($text -match $sensitivePattern) {
                $sensitiveHits += (Get-RelativePath -Path $file.FullName)
            }
        }
    }
    Add-Check -Name "secret-like-patterns" -Ok ($sensitiveHits.Count -eq 0) -Detail (($sensitiveHits | Sort-Object -Unique) -join ", ")

    $ok = ($failures.Count -eq 0)
    $result = [System.Collections.Specialized.OrderedDictionary]::new()
    $result.Add("ok", $ok)
    $result.Add("checked_at", (Get-Date).ToString("s"))
    $result.Add("root", $root)
    $result.Add("public_file_count", $publicFiles.Count)
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
