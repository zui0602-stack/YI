param(
    [string]$OutputPath = "sources/learning-status.generated.json"
)

$ErrorActionPreference = "Stop"

$root = (Resolve-Path -LiteralPath (Join-Path $PSScriptRoot "..")).Path

function Read-Text {
    param([string]$Path)
    return Get-Content -Raw -Encoding utf8 -LiteralPath (Join-Path $root $Path)
}

function Match-Number {
    param(
        [string]$Text,
        [string]$Pattern,
        [int]$Default = 0
    )
    $match = [regex]::Match($Text, $Pattern)
    if ($match.Success) {
        return [int]$match.Groups[1].Value
    }
    return $Default
}

function Match-String {
    param(
        [string]$Text,
        [string]$Pattern,
        [string]$Default = ""
    )
    $match = [regex]::Match($Text, $Pattern)
    if ($match.Success) {
        return $match.Groups[1].Value.Trim()
    }
    return $Default
}

function Get-MarkdownTableNumbers {
    param([string]$Text)
    $numbers = @()
    foreach ($match in [regex]::Matches($Text, "(?m)^\|[^|\r\n]+\|\s*(\d+)\s*\|(?:[^|\r\n]*\|)?$")) {
        $numbers += [int]$match.Groups[1].Value
    }
    return $numbers
}

Push-Location $root
try {
    $category3 = Read-Text "sources/category-3-topic-coverage.md"
    $category4 = Read-Text "sources/category-4-api-scan.md"
    $ledger = Read-Text "sources/deep-read-ledger.md"
    $progress = Read-Text "docs/progress-dashboard.md"

    $coverageRaw = & powershell -NoProfile -ExecutionPolicy Bypass -File ".\tools\verify-category3-coverage.ps1" | Out-String
    $coverage = $coverageRaw | ConvertFrom-Json
    $category3Numbers = @(Get-MarkdownTableNumbers -Text $category3)
    $category4Numbers = @(Get-MarkdownTableNumbers -Text $category4)

    $deepReadFiles = @()
    if (Test-Path -LiteralPath "sources/deep-reads") {
        $deepReadFiles = @(
            Get-ChildItem -LiteralPath "sources/deep-reads" -Filter "*.md" -File |
                Where-Object { $_.Name -ne "README.md" }
        )
    }

    $batchRows = @()
    foreach ($line in ($ledger -split "\r?\n")) {
        if ($line -match "^\|\s*([^|]+?)\s*\|\s*(\d+)\s*\|\s*([^|]+?)\s*\|\s*(\d+)\s*\|\s*([^|]+?)\s*\|\s*([^|]+?)\s*\|$") {
            $rowMatches = @{}
            foreach ($key in $matches.Keys) {
                $rowMatches[$key] = $matches[$key]
            }
            $batchName = $rowMatches[1].Trim()
            if ($batchName -ne "Batch") {
                $plannedRaw = $rowMatches[3].Trim()
                $planned = $null
                if ($plannedRaw -match "^\d+$") {
                    $planned = [int]$plannedRaw
                }
                $batchRows += [pscustomobject]@{
                    batch = $batchName
                    category = [int]$rowMatches[2]
                    planned = $planned
                    planned_raw = $plannedRaw
                    done = [int]$rowMatches[4]
                    status = $rowMatches[5].Trim()
                    evidence = $rowMatches[6].Trim()
                }
            }
        }
    }

    $forumStatusLines = @(
        $progress -split "\r?\n" |
            Where-Object { $_ -match "^2026-[0-9]{2}-[0-9]{2}\s+[0-9]{2}:[0-9]{2}" }
    )
    $forumStatus = "not recorded"
    if ($forumStatusLines.Count -gt 0) {
        $forumStatus = $forumStatusLines[-1].Trim()
    }

    $status = [System.Collections.Specialized.OrderedDictionary]::new()
    $status.Add("generated_at", (Get-Date).ToString("s"))
    $status.Add("scope", [ordered]@{
        category_3 = "all tutorial threads, no date cutoff"
        category_4 = "paused by user request on 2026-06-18"
        source_urls = @(
            "https://bbs.zdjl.site/#/thread/category/3"
        )
    })
    $status.Add("category_3", [ordered]@{
        manifest_count = [int]$coverage.manifest_count
        coverage_total = [int]$coverage.coverage_total
        coverage_unique = [int]$coverage.coverage_unique
        missing_count = [int]$coverage.missing_count
        extra_count = [int]$coverage.extra_count
        duplicate_count = [int]$coverage.duplicate_count
        specialized = $category3Numbers[1]
        source_summary_only = $category3Numbers[2]
        not_yet_specialized = $category3Numbers[3]
    })
    $status.Add("category_4", [ordered]@{
        paused_by_user = $true
        active_learning = $false
        note = "User requested Category 4 should not be learned further on 2026-06-18. Historical notes are retained but not part of completion."
        api_total_threads = $category4Numbers[0]
        deduped_threads = $category4Numbers[1]
        actual_category_4 = $category4Numbers[2]
        valid_after_2024_01_01 = $category4Numbers[3]
        excluded_before_2024 = $category4Numbers[4]
        old_bumped_excluded = $category4Numbers[5]
        high_value_candidates = 1565
        representative_qna_summarized = "145+"
    })
    $status.Add("deep_read", [ordered]@{
        formal_record_count = $deepReadFiles.Count
        batches = [object[]]$batchRows
    })
    $status.Add("github_readiness", [ordered]@{
        has_contributing = (Test-Path -LiteralPath "CONTRIBUTING.md")
        has_security = (Test-Path -LiteralPath "SECURITY.md")
        has_upload_guide = (Test-Path -LiteralPath "docs/github-upload-guide.md")
        has_github_actions = (Test-Path -LiteralPath ".github/workflows/verify-learning-library.yml")
        has_pr_template = (Test-Path -LiteralPath ".github/PULL_REQUEST_TEMPLATE.md")
        has_issue_templates = (
            (Test-Path -LiteralPath ".github/ISSUE_TEMPLATE/deep-read-batch.md") -and
            (Test-Path -LiteralPath ".github/ISSUE_TEMPLATE/source-attribution-review.md") -and
            (Test-Path -LiteralPath ".github/ISSUE_TEMPLATE/forum-recovery-sync.md")
        )
        has_package_verifier = (Test-Path -LiteralPath "tools/verify-github-package.ps1")
        has_learned_classification = (Test-Path -LiteralPath "sources/learned-tutorial-classification.json")
        has_learned_traceability = (Test-Path -LiteralPath "sources/learned-thread-traceability.json")
    })
    $status.Add("forum_status", [ordered]@{
        latest_recorded_probe = $forumStatus
        can_mark_unread_done = $false
        next_batch = "c3-04"
        access_checkpoint = "sources/category-3-c3-04-access-log.md"
        access_note = "Browser-style access completed source-00 through c3-03 earlier, but 2026-06-19 c3-04 attempts hit 504/connection errors in Codex-accessible routes. Unread batches require source recovery before they can be marked learned."
    })
    $status.Add("completion", [ordered]@{
        complete = $false
        blockers = @(
            "Category 3 still has not-yet-specialized threads.",
            "Category 4 is paused by user request and is no longer part of active completion."
        )
    })

    $json = $status | ConvertTo-Json -Depth 10
    $target = Join-Path $root $OutputPath
    $parent = Split-Path -Parent $target
    if (-not (Test-Path -LiteralPath $parent)) {
        New-Item -ItemType Directory -Path $parent | Out-Null
    }
    Set-Content -LiteralPath $target -Value $json -Encoding utf8
    $json
}
finally {
    Pop-Location
}
