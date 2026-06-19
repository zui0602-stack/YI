param(
    [string]$JsonOutputPath = "sources/study-queue.full.generated.json",
    [string]$MarkdownOutputPath = "sources/study-queue.full.generated.md"
)

$ErrorActionPreference = "Stop"

$root = (Resolve-Path -LiteralPath (Join-Path $PSScriptRoot "..")).Path

function Read-Text {
    param([string]$Path)
    return Get-Content -Raw -Encoding utf8 -LiteralPath (Join-Path $root $Path)
}

function Split-Ids {
    param([string]$Text)
    $ids = @()
    foreach ($part in ($Text -split ",")) {
        $trimmed = $part.Trim()
        if ($trimmed -match "^\d+$") {
            $ids += [int]$trimmed
        }
    }
    return $ids
}

function New-ThreadItem {
    param(
        [int]$Category,
        [int]$ThreadId,
        [string]$Batch,
        [string]$Status,
        [string]$Priority,
        [string]$TopicHint = "",
        [string]$Title = ""
    )

    return [ordered]@{
        category = $Category
        thread_id = $ThreadId
        url = "https://bbs.zdjl.site/#/thread/detail/$ThreadId"
        batch = $Batch
        status = $Status
        priority = $Priority
        topic_hint = $TopicHint
        title = $Title
    }
}

Push-Location $root
try {
    $c3Plan = Read-Text "sources/category-3-continuation-plan.md"
    $category3Batches = New-Object System.Collections.Generic.List[object]
    $category3Threads = New-Object System.Collections.Generic.List[object]

    foreach ($line in ($c3Plan -split "\r?\n")) {
        if ($line -match '^\|\s*(source-00)\s*\|\s*([^|]+?)\s*\|') {
            continue
        }
        elseif ($line -match '^\|\s*(c3-\d+)\s*\|\s*(\d+)\s*\|\s*([^|]+?)\s*\|$') {
            $batch = $matches[1]
            $count = [int]$matches[2]
            $ids = Split-Ids $matches[3]
            $items = @()
            foreach ($id in $ids) {
                $priority = if ($batch -eq "c3-01") { "high" } else { "normal" }
                $item = New-ThreadItem -Category 3 -ThreadId $id -Batch $batch -Status "not-yet-specialized" -Priority $priority -TopicHint "needs source reread and topic routing"
                $items += $item
                $category3Threads.Add($item) | Out-Null
            }
            $category3Batches.Add([ordered]@{
                batch = $batch
                count = $count
                status = "pending"
                ids = $ids
            }) | Out-Null
        }
    }

    $result = [ordered]@{
        generated_at = (Get-Date).ToString("s")
        note = "This queue is not proof of completion. It only records the next reading work."
        category_3 = [ordered]@{
            source_summary_count = @($category3Threads | Where-Object { $_.status -eq "source-summary-only" }).Count
            not_yet_specialized_count = @($category3Threads | Where-Object { $_.status -eq "not-yet-specialized" }).Count
            batches = [object[]]$category3Batches.ToArray()
            threads = [object[]]$category3Threads.ToArray()
        }
        category_4 = [ordered]@{
            paused_by_user = $true
            active_learning = $false
            note = "Paused by user request on 2026-06-18. Do not add Category 4 to the active learning queue."
            priority_candidate_count = 0
            priority_candidates = @()
        }
        completion = [ordered]@{
            complete = $false
            can_mark_done_without_forum = $false
        }
    }

    $json = $result | ConvertTo-Json -Depth 12
    Set-Content -LiteralPath (Join-Path $root $JsonOutputPath) -Value $json -Encoding utf8

    $md = New-Object System.Collections.Generic.List[string]
    $md.Add("# Full Study Queue") | Out-Null
    $md.Add("") | Out-Null
    $md.Add("Generated at: " + $result.generated_at) | Out-Null
    $md.Add("") | Out-Null
    $md.Add("This file is a reading queue, not proof of completion.") | Out-Null
    $md.Add("") | Out-Null
    $md.Add("## Summary") | Out-Null
    $md.Add("") | Out-Null
    $md.Add("| Area | Count |") | Out-Null
    $md.Add("|---|---:|") | Out-Null
    $md.Add("| Category 3 source-summary only | " + $result.category_3.source_summary_count + " |") | Out-Null
    $md.Add("| Category 3 not yet specialized | " + $result.category_3.not_yet_specialized_count + " |") | Out-Null
    $md.Add("| Category 4 priority candidates | 0 (paused by user request) |") | Out-Null
    $md.Add("") | Out-Null
    $md.Add("## Category 3 Batches") | Out-Null
    $md.Add("") | Out-Null
    $md.Add("| Batch | Count | Status |") | Out-Null
    $md.Add("|---|---:|---|") | Out-Null
    foreach ($batch in $category3Batches) {
        $md.Add("| " + $batch.batch + " | " + $batch.count + " | " + $batch.status + " |") | Out-Null
    }
    $md.Add("") | Out-Null
    $md.Add("## Category 4") | Out-Null
    $md.Add("") | Out-Null
    $md.Add("Paused by user request on 2026-06-18. Category 4 is retained only as historical reference and is not part of the active learning queue.") | Out-Null
    $md.Add("") | Out-Null
    $md.Add("## Next Rule") | Out-Null
    $md.Add("") | Out-Null
    $md.Add("Do not mark any item done until the source can be read, summarized, routed to topic notes, safety-reviewed, and verified.") | Out-Null

    Set-Content -LiteralPath (Join-Path $root $MarkdownOutputPath) -Value ($md -join [Environment]::NewLine) -Encoding utf8
    $json
}
finally {
    Pop-Location
}
