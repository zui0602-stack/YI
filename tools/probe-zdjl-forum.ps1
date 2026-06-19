param(
    [int]$TimeoutSec = 20,
    [int[]]$ThreadIds = @(17748, 2781)
)

$ErrorActionPreference = "Continue"

$headers = @{
    "mbbs-domain" = "zdjl.mbbs.cc"
    "accept" = "application/json,text/plain,*/*"
}

function Invoke-Probe {
    param(
        [string]$Name,
        [string]$Url,
        [hashtable]$Headers = @{}
    )

    try {
        $response = Invoke-WebRequest -Uri $Url -Headers $Headers -TimeoutSec $TimeoutSec -UseBasicParsing
        $content = [string]$response.Content
        $headLength = [Math]::Min(300, $content.Length)
        [ordered]@{
            name = $Name
            url = $Url
            ok = $true
            status = [int]$response.StatusCode
            content_type = $response.Headers["Content-Type"]
            head = $content.Substring(0, $headLength)
        }
    }
    catch {
        [ordered]@{
            name = $Name
            url = $Url
            ok = $false
            error = $_.Exception.Message
        }
    }
}

$results = @()
$results += Invoke-Probe -Name "category-page" -Url "https://bbs.zdjl.site/#/thread/category/3"
$results += Invoke-Probe -Name "category-api" -Url "https://bbs.zdjl.site/bbs/threads/list?category_id=3&page_offset=0&page_limit=1&sort=-posted_at" -Headers $headers

foreach ($threadId in $ThreadIds) {
    $results += Invoke-Probe -Name "thread-page-$threadId" -Url "https://bbs.zdjl.site/#/thread/detail/$threadId"
    $results += Invoke-Probe -Name "thread-api-$threadId" -Url "https://bbs.zdjl.site/bbs/threads/$threadId" -Headers $headers
}

[ordered]@{
    checked_at = (Get-Date).ToString("s")
    timeout_sec = $TimeoutSec
    results = $results
} | ConvertTo-Json -Depth 6

if (($results | Where-Object { -not $_.ok }).Count -gt 0) {
    exit 1
}
