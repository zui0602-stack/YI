param(
    [string]$RawDir = "sources/raw-browser-c3-04",
    [string]$OutputDir = "tmp/deep-read-review",
    [int]$CategoryId = 3,
    [string]$Batch = "",
    [int[]]$ThreadIds = @(),
    [switch]$AllowMissing
)

$ErrorActionPreference = "Stop"

$category3Batches = @{
    "c3-04" = @(17723, 20880, 19820, 547, 18034, 7819, 20593, 16774, 13280, 19666, 21083, 17676, 17694, 11207, 20884, 996, 14729, 860, 4673, 17258)
    "c3-05" = @(9293, 235, 20139, 2216, 14471, 12405, 19519, 17274, 20012, 9428, 19987, 215, 14770, 19802, 6206, 14991, 19593, 959, 712, 18503)
    "c3-06" = @(11433, 11833, 813, 203, 6202, 17975, 2321, 18825, 18809, 17734, 7333, 18480, 17743, 18041, 13622, 10643, 17843, 13448, 17733, 17721)
    "c3-07" = @(17642, 17432, 14723, 13510, 924, 5945, 11861, 17114, 3425, 10637, 6208, 16233, 14908, 16151, 15574, 5942, 14820, 10330, 11360, 14496)
    "c3-08" = @(15246, 15143, 13519, 13703, 15001, 6882, 708, 13535, 9273, 11781, 14330, 14329, 13518, 13526, 14132, 4397, 1289, 13696, 13522, 133)
    "c3-09" = @(13611, 13540, 13548, 13541, 13539, 13536, 13529, 13520, 13523, 13478, 12535, 13251, 5316, 12529, 12564, 847, 7197, 9379, 1477, 2624)
    "c3-10" = @(1114, 10719, 10512, 10673, 4522, 5555, 3728, 3280, 1744, 1769, 1655, 856)
}

function Ensure-Directory {
    param([string]$Path)
    if (-not (Test-Path -LiteralPath $Path)) {
        New-Item -ItemType Directory -Path $Path | Out-Null
    }
}

function Get-PathValue {
    param(
        [object]$Object,
        [string]$Path
    )

    if ($null -eq $Object -or [string]::IsNullOrWhiteSpace($Path)) {
        return $null
    }

    $current = $Object
    foreach ($part in ($Path -split "\.")) {
        if ($null -eq $current) {
            return $null
        }

        if ($current -is [System.Collections.IDictionary]) {
            if ($current.Contains($part)) {
                $current = $current[$part]
                continue
            }
            return $null
        }

        $property = $current.PSObject.Properties[$part]
        if ($null -eq $property) {
            return $null
        }
        $current = $property.Value
    }

    return $current
}

function Get-FirstValue {
    param(
        [object]$Object,
        [string[]]$Paths
    )

    foreach ($path in $Paths) {
        $value = Get-PathValue -Object $Object -Path $path
        if ($null -ne $value -and "$value".Trim().Length -gt 0) {
            return "$value"
        }
    }
    return ""
}

function Get-FirstObject {
    param([object]$Object)

    if ($null -eq $Object) {
        return $null
    }

    if ($Object -is [System.Array]) {
        if ($Object.Count -gt 0) {
            return $Object[0]
        }
        return $null
    }

    foreach ($path in @("data.thread", "data.item", "data.detail", "data", "thread", "item", "result")) {
        $value = Get-PathValue -Object $Object -Path $path
        if ($null -eq $value) {
            continue
        }
        if ($value -is [System.Array]) {
            if ($value.Count -gt 0) {
                return $value[0]
            }
            continue
        }
        return $value
    }

    return $Object
}

function Get-FirstArray {
    param([object]$Object)

    if ($null -eq $Object) {
        return @()
    }

    if ($Object -is [System.Array]) {
        return @($Object)
    }

    foreach ($path in @("data.items", "data.list", "data.rows", "data.records", "data.posts", "items", "list", "rows", "records", "posts", "data")) {
        $value = Get-PathValue -Object $Object -Path $path
        if ($value -is [System.Array]) {
            return @($value)
        }
    }

    return @()
}

function Convert-Preview {
    param(
        [string]$Value,
        [int]$Length = 900
    )

    if ([string]::IsNullOrWhiteSpace($Value)) {
        return "_No preview text recovered._"
    }

    $text = $Value -replace "<[^>]+>", " "
    $text = $text -replace "\s+", " "
    $text = $text.Trim()
    if ($text.Length -gt $Length) {
        return $text.Substring(0, $Length) + "..."
    }
    return $text
}

function Convert-SafeFileName {
    param([string]$Value)

    if ([string]::IsNullOrWhiteSpace($Value)) {
        return "untitled"
    }

    $safe = $Value -replace '[\\/:*?"<>|]', "-"
    $safe = $safe -replace "\s+", "-"
    $safe = $safe.Trim("-")
    if ($safe.Length -gt 40) {
        return $safe.Substring(0, 40)
    }
    if ($safe.Length -eq 0) {
        return "untitled"
    }
    return $safe
}

if ($ThreadIds.Count -eq 0) {
    if ([string]::IsNullOrWhiteSpace($Batch)) {
        throw "Provide -Batch or -ThreadIds."
    }
    if (-not $category3Batches.ContainsKey($Batch)) {
        throw "Unknown batch '$Batch'. Known batches: $($category3Batches.Keys -join ', ')"
    }
    $ThreadIds = $category3Batches[$Batch]
}

if (-not (Test-Path -LiteralPath $RawDir) -and -not $AllowMissing) {
    throw "RawDir not found: $RawDir. Use -AllowMissing to create a missing-data review packet."
}

Ensure-Directory -Path $OutputDir

$threadsDir = Join-Path $RawDir "threads"
$postsDir = Join-Path $RawDir "posts"
$results = New-Object System.Collections.Generic.List[object]

foreach ($threadId in $ThreadIds) {
    $flags = New-Object System.Collections.Generic.List[string]
    $title = "thread-$threadId"
    $createdAt = ""
    $mainText = ""
    $replyText = ""
    $replyCount = 0
    $threadPath = Join-Path $threadsDir "$threadId.json"

    if (Test-Path -LiteralPath $threadPath) {
        try {
            $threadJson = Get-Content -Raw -LiteralPath $threadPath | ConvertFrom-Json
            $threadObject = Get-FirstObject -Object $threadJson
            $titleValue = Get-FirstValue -Object $threadObject -Paths @("title", "subject", "name")
            if ($titleValue) {
                $title = $titleValue
            }
            $createdAt = Get-FirstValue -Object $threadObject -Paths @("created_at", "createdAt", "create_time", "created", "posted_at", "postedAt")
            $mainText = Get-FirstValue -Object $threadObject -Paths @("content", "body", "markdown", "html", "text", "message", "detail")
        }
        catch {
            $flags.Add("thread-json-error") | Out-Null
        }
    }
    else {
        $flags.Add("missing-thread-json") | Out-Null
    }

    $postFiles = @()
    if (Test-Path -LiteralPath $postsDir) {
        $postFiles = @(Get-ChildItem -LiteralPath $postsDir -Filter "$threadId-page-*.json" -File | Sort-Object Name)
    }

    foreach ($postFile in $postFiles) {
        try {
            $postsJson = Get-Content -Raw -LiteralPath $postFile.FullName | ConvertFrom-Json
            $posts = Get-FirstArray -Object $postsJson
            $replyCount += $posts.Count
            foreach ($post in $posts) {
                $postText = Get-FirstValue -Object $post -Paths @("content", "body", "markdown", "html", "text", "message")
                if ($postText) {
                    $replyText += " " + $postText
                }
            }
        }
        catch {
            $flags.Add("posts-json-error") | Out-Null
        }
    }

    if ($postFiles.Count -eq 0) {
        $flags.Add("missing-posts") | Out-Null
    }

    $combined = "$title $mainText $replyText"
    if ($combined -match '(?i)```|function\s|\bvar\s|\blet\s|\bconst\s|=>|if\s*\(|for\s*\(|findNode|OCR|getVar|setVar|runAction|http') {
        $flags.Add("code-or-api") | Out-Null
    }
    if ($combined -match '(?i)token|cookie|password|api\s*key|secret|card|license|auth|credential|captcha|payment') {
        $flags.Add("safety-review") | Out-Null
    }
    if ($combined -match '(?i)png|jpg|jpeg|gif|mp4|video|attachment|upload|image|media|file') {
        $flags.Add("media-check") | Out-Null
    }

    $flagText = if ($flags.Count -eq 0) { "none" } else { (($flags.ToArray() | Sort-Object -Unique) -join ", ") }
    $safeTitle = Convert-SafeFileName -Value $title
    $reviewName = "category{0}-{1}-{2}.md" -f $CategoryId, $threadId, $safeTitle
    if ($reviewName.Length -gt 96) {
        $reviewName = "category{0}-{1}.md" -f $CategoryId, $threadId
    }

    $reviewPath = Join-Path $OutputDir $reviewName
    $sourceUrl = "https://bbs.zdjl.site/#/thread/detail/$threadId"
    $apiUrl = "https://bbs.zdjl.site/bbs/threads/$threadId"
    $postUrl = "https://bbs.zdjl.site/bbs/posts/list?thread_id=$threadId&page_offset=0&page_limit=100&sort=created_at"

    $lines = New-Object System.Collections.Generic.List[string]
    $lines.Add("# Category $CategoryId Thread $threadId Review Packet") | Out-Null
    $lines.Add("") | Out-Null
    $lines.Add("Generated at: $(Get-Date -Format s)") | Out-Null
    $lines.Add("") | Out-Null
    $lines.Add("This is a local review packet. It is not a learned result and should not be committed as a final deep-read note without human review.") | Out-Null
    $lines.Add("") | Out-Null
    $lines.Add("## Source") | Out-Null
    $lines.Add("") | Out-Null
    $lines.Add("- Forum URL: $sourceUrl") | Out-Null
    $lines.Add("- Thread API: $apiUrl") | Out-Null
    $lines.Add("- Posts API: $postUrl") | Out-Null
    $lines.Add("") | Out-Null
    $lines.Add("## Extracted Metadata") | Out-Null
    $lines.Add("") | Out-Null
    $lines.Add("- Title: $title") | Out-Null
    $lines.Add("- Created at: $createdAt") | Out-Null
    $lines.Add("- Reply records loaded: $replyCount") | Out-Null
    $lines.Add("- Flags: $flagText") | Out-Null
    $lines.Add("") | Out-Null
    $lines.Add("## Main Preview") | Out-Null
    $lines.Add("") | Out-Null
    $lines.Add((Convert-Preview -Value $mainText)) | Out-Null
    $lines.Add("") | Out-Null
    $lines.Add("## Reply Preview") | Out-Null
    $lines.Add("") | Out-Null
    $lines.Add((Convert-Preview -Value $replyText)) | Out-Null
    $lines.Add("") | Out-Null
    $lines.Add("## Review Checklist") | Out-Null
    $lines.Add("") | Out-Null
    $lines.Add("- Confirm real created_at before applying any date cutoff.") | Out-Null
    $lines.Add("- Identify tutorial value: API, setup, UI flow, code pattern, troubleshooting, video, or attachment.") | Out-Null
    $lines.Add("- Summarize the reusable architecture without copying full source posts or private material.") | Out-Null
    $lines.Add("- If code/API is present, route the learning to the correct docs file.") | Out-Null
    $lines.Add("- If safety-review is present, redact credentials, tokens, paid-license material, bypass steps, and risky endpoints.") | Out-Null
    $lines.Add("- Only after review, create or update `sources/deep-reads/category$CategoryId-$threadId.md`.") | Out-Null

    $lines | Set-Content -LiteralPath $reviewPath -Encoding utf8

    $results.Add([pscustomobject]@{
        thread_id = $threadId
        title = $title
        created_at = $createdAt
        reply_count = $replyCount
        flags = @($flags.ToArray() | Sort-Object -Unique)
        review_path = $reviewPath
    }) | Out-Null
}

$indexPath = Join-Path $OutputDir "index.md"
$indexLines = New-Object System.Collections.Generic.List[string]
$indexLines.Add("# Deep-Read Review Packet Index") | Out-Null
$indexLines.Add("") | Out-Null
$indexLines.Add("- Category: $CategoryId") | Out-Null
$indexLines.Add("- Batch: $Batch") | Out-Null
$indexLines.Add("- RawDir: $RawDir") | Out-Null
$indexLines.Add("- Generated at: $(Get-Date -Format s)") | Out-Null
$indexLines.Add("") | Out-Null
$indexLines.Add("| Thread ID | Created at | Flags | Review |") | Out-Null
$indexLines.Add("|---:|---|---|---|") | Out-Null
foreach ($result in $results) {
    $relative = Split-Path -Leaf $result.review_path
    $flagsText = if ($result.flags.Count -eq 0) { "none" } else { ($result.flags -join ", ") }
    $indexLines.Add("| $($result.thread_id) | $($result.created_at) | $flagsText | [$relative]($relative) |") | Out-Null
}
$indexLines | Set-Content -LiteralPath $indexPath -Encoding utf8

$summary = [pscustomobject]@{
    ok = $true
    generated_at = (Get-Date -Format s)
    category = $CategoryId
    batch = $Batch
    raw_dir = $RawDir
    output_dir = $OutputDir
    thread_count = $results.Count
    missing_thread_json_count = @($results | Where-Object { $_.flags -contains "missing-thread-json" }).Count
    missing_posts_count = @($results | Where-Object { $_.flags -contains "missing-posts" }).Count
    review_index = $indexPath
    results = $results
}

$summaryPath = Join-Path $OutputDir "summary.json"
$summary | ConvertTo-Json -Depth 8 | Set-Content -LiteralPath $summaryPath -Encoding utf8
$summary | ConvertTo-Json -Depth 8
