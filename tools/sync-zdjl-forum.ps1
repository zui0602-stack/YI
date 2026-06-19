param(
    [int[]]$CategoryIds = @(3, 4),
    [string]$OutputDir = "sources/raw",
    [int]$PageLimit = 100,
    [int]$TimeoutSec = 20,
    [int]$MaxPages = 0,
    [switch]$FetchThreadDetails,
    [switch]$FetchPosts,
    [int[]]$ThreadIds = @(),
    [datetime]$Category4CreatedAfter = "2024-01-01"
)

$ErrorActionPreference = "Stop"

$headers = @{
    "mbbs-domain" = "zdjl.mbbs.cc"
    "accept" = "application/json,text/plain,*/*"
}

function Ensure-Directory {
    param([string]$Path)
    if (-not (Test-Path -LiteralPath $Path)) {
        New-Item -ItemType Directory -Path $Path | Out-Null
    }
}

function Get-Prop {
    param(
        [object]$Object,
        [string]$Name
    )
    if ($null -eq $Object) {
        return $null
    }
    if ($Object -is [System.Collections.IDictionary]) {
        if ($Object.Contains($Name)) {
            return $Object[$Name]
        }
        return $null
    }
    $prop = $Object.PSObject.Properties[$Name]
    if ($null -ne $prop) {
        return $prop.Value
    }
    return $null
}

function Get-Nested {
    param(
        [object]$Object,
        [string]$Path
    )
    $current = $Object
    foreach ($part in $Path.Split(".")) {
        $current = Get-Prop -Object $current -Name $part
        if ($null -eq $current) {
            return $null
        }
    }
    return $current
}

function Get-FirstArray {
    param(
        [object]$Object,
        [string[]]$Paths
    )
    foreach ($path in $Paths) {
        $value = Get-Nested -Object $Object -Path $path
        if ($null -eq $value) {
            continue
        }
        if ($value -is [array]) {
            return @($value)
        }
        if ($value -is [System.Collections.IEnumerable] -and -not ($value -is [string])) {
            return @($value)
        }
    }
    return @()
}

function Get-FirstValue {
    param(
        [object]$Object,
        [string[]]$Names
    )
    foreach ($name in $Names) {
        $value = Get-Nested -Object $Object -Path $name
        if ($null -ne $value -and "$value" -ne "") {
            return $value
        }
    }
    return $null
}

function Convert-ForumDate {
    param([object]$Value)
    if ($null -eq $Value -or "$Value" -eq "") {
        return $null
    }
    try {
        if ($Value -is [int] -or $Value -is [long] -or "$Value" -match '^\d+$') {
            $number = [int64]$Value
            if ($number -gt 999999999999) {
                return [DateTimeOffset]::FromUnixTimeMilliseconds($number).LocalDateTime
            }
            return [DateTimeOffset]::FromUnixTimeSeconds($number).LocalDateTime
        }
        return [datetime]::Parse("$Value")
    }
    catch {
        return $null
    }
}

function Invoke-ForumJson {
    param([string]$Url)
    Invoke-RestMethod -Uri $Url -Headers $headers -TimeoutSec $TimeoutSec -UseBasicParsing
}

function Save-Json {
    param(
        [object]$Object,
        [string]$Path
    )
    $json = $Object | ConvertTo-Json -Depth 30
    Set-Content -LiteralPath $Path -Value $json -Encoding utf8
}

Ensure-Directory -Path $OutputDir
Ensure-Directory -Path (Join-Path $OutputDir "categories")
Ensure-Directory -Path (Join-Path $OutputDir "threads")
Ensure-Directory -Path (Join-Path $OutputDir "posts")

$syncStarted = Get-Date
$categorySummaries = @()
$allThreadIds = New-Object System.Collections.Generic.List[int]
$errors = New-Object System.Collections.Generic.List[object]

foreach ($categoryId in $CategoryIds) {
    $categoryDir = Join-Path (Join-Path $OutputDir "categories") "category-$categoryId"
    Ensure-Directory -Path $categoryDir

    $items = New-Object System.Collections.Generic.List[object]
    $offset = 0
    $pageIndex = 0
    $stop = $false

    while (-not $stop) {
        if ($MaxPages -gt 0 -and $pageIndex -ge $MaxPages) {
            break
        }

        $url = "https://bbs.zdjl.site/bbs/threads/list?category_id=$categoryId&page_offset=$offset&page_limit=$PageLimit&sort=-posted_at"
        try {
            $response = Invoke-ForumJson -Url $url
            $rawPath = Join-Path $categoryDir ("page-{0:D4}.json" -f $pageIndex)
            Save-Json -Object $response -Path $rawPath

            $pageItems = Get-FirstArray -Object $response -Paths @(
                "data.list",
                "data.threads",
                "data.items",
                "data.rows",
                "list",
                "threads",
                "items",
                "rows"
            )

            foreach ($item in $pageItems) {
                $items.Add($item)
                $id = Get-FirstValue -Object $item -Names @("id", "thread_id", "threadId")
                if ($null -ne $id -and "$id" -match '^\d+$') {
                    $allThreadIds.Add([int]$id)
                }
            }

            if ($pageItems.Count -lt $PageLimit) {
                $stop = $true
            }
            $offset += $PageLimit
            $pageIndex += 1
        }
        catch {
            $errors.Add([ordered]@{
                scope = "category"
                category_id = $categoryId
                page_index = $pageIndex
                url = $url
                error = $_.Exception.Message
            })
            break
        }
    }

    $uniqueItems = @{}
    foreach ($item in $items) {
        $id = Get-FirstValue -Object $item -Names @("id", "thread_id", "threadId")
        if ($null -ne $id) {
            $uniqueItems["$id"] = $item
        }
    }

    $effectiveCount = 0
    if ($categoryId -eq 4) {
        foreach ($item in $uniqueItems.Values) {
            $createdAt = Convert-ForumDate (Get-FirstValue -Object $item -Names @("created_at", "createdAt", "create_time", "created"))
            if ($null -ne $createdAt -and $createdAt -ge $Category4CreatedAfter) {
                $effectiveCount += 1
            }
        }
    }
    else {
        $effectiveCount = $uniqueItems.Count
    }

    $manifestPath = Join-Path $categoryDir "manifest.json"
    Save-Json -Object ([ordered]@{
        category_id = $categoryId
        fetched_at = (Get-Date).ToString("s")
        page_limit = $PageLimit
        pages_fetched = $pageIndex
        raw_items = $items.Count
        unique_threads = $uniqueItems.Count
        effective_threads = $effectiveCount
        category4_created_after = $Category4CreatedAfter.ToString("yyyy-MM-dd")
        thread_ids = @($uniqueItems.Keys | Sort-Object { [int]$_ })
    }) -Path $manifestPath

    $categorySummaries += [ordered]@{
        category_id = $categoryId
        pages_fetched = $pageIndex
        raw_items = $items.Count
        unique_threads = $uniqueItems.Count
        effective_threads = $effectiveCount
        manifest = $manifestPath
    }
}

$detailIds = @()
if ($ThreadIds.Count -gt 0) {
    $detailIds = @($ThreadIds | Sort-Object -Unique)
}
elseif ($FetchThreadDetails -or $FetchPosts) {
    $detailIds = @($allThreadIds | Sort-Object -Unique)
}

foreach ($threadId in $detailIds) {
    if ($FetchThreadDetails) {
        $url = "https://bbs.zdjl.site/bbs/threads/$threadId"
        try {
            $response = Invoke-ForumJson -Url $url
            Save-Json -Object $response -Path (Join-Path (Join-Path $OutputDir "threads") "$threadId.json")
        }
        catch {
            $errors.Add([ordered]@{
                scope = "thread"
                thread_id = $threadId
                url = $url
                error = $_.Exception.Message
            })
        }
    }

    if ($FetchPosts) {
        $postOffset = 0
        $postPage = 0
        $postStop = $false
        while (-not $postStop) {
            if ($MaxPages -gt 0 -and $postPage -ge $MaxPages) {
                break
            }
            $url = "https://bbs.zdjl.site/bbs/posts/list?thread_id=$threadId&page_offset=$postOffset&page_limit=$PageLimit&sort=created_at"
            try {
                $response = Invoke-ForumJson -Url $url
                Save-Json -Object $response -Path (Join-Path (Join-Path $OutputDir "posts") ("{0}-page-{1:D4}.json" -f $threadId, $postPage))
                $postItems = Get-FirstArray -Object $response -Paths @(
                    "data.list",
                    "data.posts",
                    "data.items",
                    "data.rows",
                    "list",
                    "posts",
                    "items",
                    "rows"
                )
                if ($postItems.Count -lt $PageLimit) {
                    $postStop = $true
                }
                $postOffset += $PageLimit
                $postPage += 1
            }
            catch {
                $errors.Add([ordered]@{
                    scope = "posts"
                    thread_id = $threadId
                    page_index = $postPage
                    url = $url
                    error = $_.Exception.Message
                })
                break
            }
        }
    }
}

$summary = [System.Collections.Specialized.OrderedDictionary]::new()
$categorySummaryArray = [object[]]@($categorySummaries)
$errorArray = [object[]]$errors.ToArray()
$summary.Add("checked_at", (Get-Date).ToString("s"))
$summary.Add("started_at", $syncStarted.ToString("s"))
$summary.Add("output_dir", (Resolve-Path -LiteralPath $OutputDir).Path)
$summary.Add("categories", [object]$categorySummaryArray)
$summary.Add("requested_thread_details", [bool]$FetchThreadDetails)
$summary.Add("requested_posts", [bool]$FetchPosts)
$summary.Add("detail_thread_count", @($detailIds).Count)
$summary.Add("error_count", $errors.Count)
$summary.Add("errors", [object]$errorArray)

Save-Json -Object $summary -Path (Join-Path $OutputDir "sync-summary.json")
$summary | ConvertTo-Json -Depth 10

if ($errors.Count -gt 0) {
    exit 1
}
