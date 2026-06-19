param(
    [switch]$CheckForum
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

Push-Location $root
try {
    $requiredFiles = @(
        ".gitignore",
        ".github/workflows/verify-learning-library.yml",
        ".github/PULL_REQUEST_TEMPLATE.md",
        ".github/ISSUE_TEMPLATE/config.yml",
        ".github/ISSUE_TEMPLATE/deep-read-batch.md",
        ".github/ISSUE_TEMPLATE/source-attribution-review.md",
        ".github/ISSUE_TEMPLATE/forum-recovery-sync.md",
        "CONTRIBUTING.md",
        "START_HERE.md",
        "README.md",
        "SECURITY.md",
        "virtual_test_flow.md",
        "docs/learned-tutorial-classification.md",
        "docs/learning-library-index.md",
        "docs/tutorial-learning-roadmap.md",
        "docs/progress-dashboard.md",
        "docs/forum-sync-workflow.md",
        "docs/deep-read-protocol.md",
        "docs/category-3-c3-01-deep-read.md",
        "docs/category-3-c3-02-deep-read.md",
        "docs/category-3-c3-03-deep-read.md",
        "docs/category-3-source-00-deep-read.md",
        "docs/source-attribution-policy.md",
        "docs/completion-audit.md",
        "docs/current-status-report.md",
        "docs/github-publishing-checklist.md",
        "docs/github-upload-guide.md",
        "sources/category-3-full-manifest.md",
        "sources/category-3-topic-coverage.md",
        "sources/category-3-continuation-plan.md",
        "sources/category-3-c3-04-access-log.md",
        "sources/category-4-api-scan.md",
        "sources/category-4-continuation-plan.md",
        "sources/deep-read-ledger.md",
        "sources/deep-reads/README.md",
        "sources/learned-tutorial-classification.json",
        "sources/learned-thread-traceability.json",
        "sources/learning-status.generated.json",
        "sources/study-queue.full.generated.json",
        "sources/study-queue.full.generated.md",
        "sources/study-queue.generated.md",
        "templates/deep-read-note.md",
        "templates/batch-review-report.md",
        "tools/probe-zdjl-forum.ps1",
        "tools/sync-zdjl-forum.ps1",
        "tools/sync-zdjl-forum-browser-fetch.mjs",
        "tools/build-study-queue.ps1",
        "tools/export-learned-traceability.ps1",
        "tools/export-learning-status.ps1",
        "tools/export-study-queue.ps1",
        "tools/new-deep-read-note.ps1",
        "tools/prepare-deep-read-review-from-raw.ps1",
        "tools/verify-deep-read-records.ps1",
        "tools/verify-github-package.ps1",
        "tools/verify-source-attribution.ps1",
        "tools/verify-category3-coverage.ps1"
    )

    $missing = @($requiredFiles | Where-Object { -not (Test-Path -LiteralPath $_) })
    Add-Check -Name "required-files" -Ok ($missing.Count -eq 0) -Detail (($missing -join ", "))

    $psErrors = New-Object System.Collections.Generic.List[string]
    foreach ($file in Get-ChildItem -LiteralPath "tools" -Filter "*.ps1" -File) {
        try {
            $text = Get-Content -Raw -Encoding utf8 -LiteralPath $file.FullName
            [scriptblock]::Create($text) | Out-Null
        }
        catch {
            $psErrors.Add($file.Name + ": " + $_.Exception.Message) | Out-Null
        }
    }
    Add-Check -Name "powershell-parse" -Ok ($psErrors.Count -eq 0) -Detail (($psErrors.ToArray()) -join " | ")

    $fenceErrors = New-Object System.Collections.Generic.List[string]
    $markdownFiles = @(
        Get-ChildItem -LiteralPath "." -File -Filter "*.md"
        Get-ChildItem -LiteralPath "docs" -Recurse -File -Filter "*.md"
        Get-ChildItem -LiteralPath "sources" -Recurse -File -Filter "*.md"
        Get-ChildItem -LiteralPath "prompts" -Recurse -File -Filter "*.md"
        Get-ChildItem -LiteralPath "tests" -Recurse -File -Filter "*.md"
    )
    foreach ($file in $markdownFiles) {
        $text = Get-Content -Raw -Encoding utf8 -LiteralPath $file.FullName
        $fence = ([string][char]96) * 3
        $ticks = ([regex]::Matches($text, [regex]::Escape($fence))).Count
        if ($ticks % 2 -ne 0) {
            $fenceErrors.Add($file.FullName + " ticks=" + $ticks) | Out-Null
        }
    }
    Add-Check -Name "markdown-fences" -Ok ($fenceErrors.Count -eq 0) -Detail (($fenceErrors.ToArray()) -join " | ")

    $jsonErrors = New-Object System.Collections.Generic.List[string]
    foreach ($file in Get-ChildItem -LiteralPath "examples" -Filter "*.json" -File) {
        try {
            Get-Content -Raw -Encoding utf8 -LiteralPath $file.FullName | ConvertFrom-Json | Out-Null
        }
        catch {
            $jsonErrors.Add($file.Name + ": " + $_.Exception.Message) | Out-Null
        }
    }
    Add-Check -Name "example-json" -Ok ($jsonErrors.Count -eq 0) -Detail (($jsonErrors.ToArray()) -join " | ")

    try {
        $coverageRaw = & powershell -NoProfile -ExecutionPolicy Bypass -File ".\tools\verify-category3-coverage.ps1" | Out-String
        $coverage = $coverageRaw | ConvertFrom-Json
        $coverageOk = (
            $coverage.manifest_count -eq 309 -and
            $coverage.coverage_total -eq 309 -and
            $coverage.coverage_unique -eq 309 -and
            $coverage.missing_count -eq 0 -and
            $coverage.extra_count -eq 0 -and
            $coverage.duplicate_count -eq 0
        )
        Add-Check -Name "category3-coverage" -Ok $coverageOk -Detail ($coverageRaw.Trim())
    }
    catch {
        Add-Check -Name "category3-coverage" -Ok $false -Detail $_.Exception.Message
    }

    try {
        $statusPath = "sources/learning-status.generated.json"
        $status = Get-Content -Raw -Encoding utf8 -LiteralPath $statusPath | ConvertFrom-Json
        $statusOk = (
            $status.category_3.manifest_count -eq 309 -and
            $status.category_3.coverage_total -eq 309 -and
            $status.category_3.coverage_unique -eq 309 -and
            $status.category_4.paused_by_user -eq $true -and
            $status.category_4.active_learning -eq $false -and
            $status.github_readiness.has_github_actions -eq $true -and
            $status.github_readiness.has_pr_template -eq $true -and
            $status.github_readiness.has_issue_templates -eq $true -and
            $status.completion.complete -eq $false
        )
        Add-Check -Name "learning-status-json" -Ok $statusOk -Detail $statusPath
    }
    catch {
        Add-Check -Name "learning-status-json" -Ok $false -Detail $_.Exception.Message
    }

    try {
        $learnedClassificationPath = "sources/learned-tutorial-classification.json"
        $learnedClassification = Get-Content -Raw -Encoding utf8 -LiteralPath $learnedClassificationPath | ConvertFrom-Json
        $learnedClassificationOk = (
            $learnedClassification.scope.category_3_total_indexed -eq 309 -and
            $learnedClassification.scope.category_3_specialized -eq 177 -and
            $learnedClassification.scope.category_4_active_learning -eq $false -and
            @($learnedClassification.categories).Count -ge 10 -and
            @($learnedClassification.deep_read_batches | Where-Object { $_.status -eq "learned" }).Count -ge 4
        )
        Add-Check -Name "learned-classification-json" -Ok $learnedClassificationOk -Detail $learnedClassificationPath
    }
    catch {
        Add-Check -Name "learned-classification-json" -Ok $false -Detail $_.Exception.Message
    }

    try {
        $learnedTraceabilityPath = "sources/learned-thread-traceability.json"
        $learnedTraceability = Get-Content -Raw -Encoding utf8 -LiteralPath $learnedTraceabilityPath | ConvertFrom-Json
        $learnedTraceabilityOk = (
            $learnedTraceability.expected_specialized_count -eq 177 -and
            $learnedTraceability.unique_thread_count -eq 177 -and
            $learnedTraceability.unique_thread_count_matches_expected -eq $true -and
            @($learnedTraceability.documents).Count -ge 10 -and
            @($learnedTraceability.documents_with_count_mismatch).Count -eq 0
        )
        Add-Check -Name "learned-thread-traceability-json" -Ok $learnedTraceabilityOk -Detail $learnedTraceabilityPath
    }
    catch {
        Add-Check -Name "learned-thread-traceability-json" -Ok $false -Detail $_.Exception.Message
    }

    try {
        $fullQueuePath = "sources/study-queue.full.generated.json"
        $fullQueue = Get-Content -Raw -Encoding utf8 -LiteralPath $fullQueuePath | ConvertFrom-Json
        $fullQueueOk = (
            $fullQueue.category_3.source_summary_count -eq 0 -and
            $fullQueue.category_3.not_yet_specialized_count -eq 132 -and
            $fullQueue.category_4.paused_by_user -eq $true -and
            $fullQueue.category_4.priority_candidate_count -eq 0 -and
            $fullQueue.completion.complete -eq $false
        )
        Add-Check -Name "full-study-queue" -Ok $fullQueueOk -Detail $fullQueuePath
    }
    catch {
        Add-Check -Name "full-study-queue" -Ok $false -Detail $_.Exception.Message
    }

    try {
        $deepReadRaw = & powershell -NoProfile -ExecutionPolicy Bypass -File ".\tools\verify-deep-read-records.ps1" | Out-String
        $deepRead = $deepReadRaw | ConvertFrom-Json
        Add-Check -Name "deep-read-records" -Ok ($deepRead.ok -eq $true) -Detail ($deepReadRaw.Trim())
        if ($deepRead.warning_count -gt 0) {
            Add-Warning ("deep-read-records warnings: " + (($deepRead.warnings) -join " | "))
        }
    }
    catch {
        Add-Check -Name "deep-read-records" -Ok $false -Detail $_.Exception.Message
    }

    try {
        $sourceRaw = & powershell -NoProfile -ExecutionPolicy Bypass -File ".\tools\verify-source-attribution.ps1" | Out-String
        $sourceAttribution = $sourceRaw | ConvertFrom-Json
        Add-Check -Name "source-attribution" -Ok ($sourceAttribution.ok -eq $true) -Detail ($sourceRaw.Trim())
        if ($sourceAttribution.warning_count -gt 0) {
            Add-Warning ("source-attribution warnings: " + (($sourceAttribution.warnings) -join " | "))
        }
    }
    catch {
        Add-Check -Name "source-attribution" -Ok $false -Detail $_.Exception.Message
    }

    try {
        $githubRaw = & powershell -NoProfile -ExecutionPolicy Bypass -File ".\tools\verify-github-package.ps1" | Out-String
        $githubPackage = $githubRaw | ConvertFrom-Json
        Add-Check -Name "github-package" -Ok ($githubPackage.ok -eq $true) -Detail ($githubRaw.Trim())
        if ($githubPackage.warning_count -gt 0) {
            Add-Warning ("github-package warnings: " + (($githubPackage.warnings) -join " | "))
        }
    }
    catch {
        Add-Check -Name "github-package" -Ok $false -Detail $_.Exception.Message
    }

    $queuePath = "sources/study-queue.generated.md"
    if (Test-Path -LiteralPath $queuePath) {
        $queue = Get-Content -Raw -Encoding utf8 -LiteralPath $queuePath
        $queueOk = ($queue -match "work queue" -and $queue -match "Category 3 state")
        Add-Check -Name "study-queue" -Ok $queueOk -Detail $queuePath
    }
    else {
        Add-Check -Name "study-queue" -Ok $false -Detail "missing"
    }

    $gitignore = if (Test-Path -LiteralPath ".gitignore") { Get-Content -Raw -Encoding utf8 -LiteralPath ".gitignore" } else { "" }
    $ignoreOk = ($gitignore -match "sources/raw/" -and $gitignore -match "sources/raw-\*/" -and $gitignore -match "tmp/")
    Add-Check -Name "gitignore-raw-output" -Ok $ignoreOk -Detail ".gitignore should exclude raw forum dumps and tmp output"

    $sensitivePattern = "API key|token|cookie|password|secret|private interface|card algorithm|management address"
    $scanFiles = @(
        Get-ChildItem -LiteralPath "." -File -Include "*.md"
        Get-ChildItem -LiteralPath "docs" -Recurse -File -Include "*.md"
        Get-ChildItem -LiteralPath "sources" -Recurse -File -Include "*.md"
        Get-ChildItem -LiteralPath "prompts" -Recurse -File -Include "*.md"
        Get-ChildItem -LiteralPath "examples" -Recurse -File
        Get-ChildItem -LiteralPath "tests" -Recurse -File -Include "*.md"
    )
    $hits = @()
    foreach ($file in $scanFiles) {
        $text = Get-Content -Raw -Encoding utf8 -LiteralPath $file.FullName
        if ($text -match $sensitivePattern) {
            $hits += $file.FullName
        }
    }
    if ($hits.Count -gt 0) {
        Add-Warning ("sensitive-keyword-hits need human review: " + (($hits | Sort-Object -Unique) -join ", "))
    }

    if ($CheckForum) {
        try {
            $probeRaw = & powershell -NoProfile -ExecutionPolicy Bypass -File ".\tools\probe-zdjl-forum.ps1" -TimeoutSec 8 | Out-String
            Add-Check -Name "forum-probe" -Ok ($LASTEXITCODE -eq 0) -Detail ($probeRaw.Trim())
        }
        catch {
            Add-Check -Name "forum-probe" -Ok $false -Detail $_.Exception.Message
        }
    }
    else {
        Add-Warning "forum-probe skipped; run with -CheckForum to test external forum availability."
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
    $result | ConvertTo-Json -Depth 8

    if (-not $ok) {
        exit 1
    }
}
finally {
    Pop-Location
}
