param(
    [Parameter(Mandatory = $true)]
    [int]$ThreadId,

    [Parameter(Mandatory = $true)]
    [int]$CategoryId,

    [string]$Title = "",
    [string]$CreatedAt = "",
    [string]$Status = "pending",
    [string]$OutputDir = "sources/deep-reads",
    [switch]$Force
)

$ErrorActionPreference = "Stop"

function Convert-Slug {
    param([string]$Value)
    $slug = "$Value".ToLowerInvariant()
    $slug = [regex]::Replace($slug, '[^a-z0-9]+', '-')
    $slug = $slug.Trim('-')
    if ($slug.Length -gt 48) {
        $slug = $slug.Substring(0, 48).Trim('-')
    }
    if ($slug -eq "") {
        $slug = "thread"
    }
    return $slug
}

if (-not (Test-Path -LiteralPath $OutputDir)) {
    New-Item -ItemType Directory -Path $OutputDir | Out-Null
}

$slug = Convert-Slug -Value $Title
$fileName = "c{0}-{1}-{2}.md" -f $CategoryId, $ThreadId, $slug
$outputPath = Join-Path $OutputDir $fileName

if ((Test-Path -LiteralPath $outputPath) -and -not $Force) {
    throw "Deep-read note already exists: $outputPath. Use -Force to overwrite."
}

$dateNow = Get-Date -Format "yyyy-MM-dd"
$sourceUrl = "https://bbs.zdjl.site/#/thread/detail/$ThreadId"
$fence = ([string][char]96) * 3

$lines = New-Object System.Collections.Generic.List[string]
function Add-Line {
    param([string]$Text = "")
    $lines.Add($Text) | Out-Null
}

Add-Line "# Deep Read Note - $ThreadId"
Add-Line
Add-Line "Generated from templates/deep-read-note.md on $dateNow."
Add-Line
Add-Line "## Source"
Add-Line
Add-Line "- Thread ID: $ThreadId"
Add-Line "- Category: $CategoryId"
Add-Line "- URL: $sourceUrl"
Add-Line "- Title: $Title"
Add-Line "- Created at: $CreatedAt"
Add-Line "- Read at:"
Add-Line "- Reader:"
Add-Line "- Raw file:"
Add-Line "- Posts file:"
Add-Line
Add-Line "## Access Check"
Add-Line
Add-Line "- Page/API opened successfully: no"
Add-Line "- Not a 504/blank/error page: no"
Add-Line "- Main post reviewed: no"
Add-Line "- Replies reviewed: no"
Add-Line "- Images reviewed: no"
Add-Line "- Video or attachment checked: no"
Add-Line
Add-Line "## Classification"
Add-Line
Add-Line "- Primary topic:"
Add-Line "- Secondary topics:"
Add-Line "- Contains code:"
Add-Line "- Contains setup/deployment:"
Add-Line "- Contains backend/API:"
Add-Line "- Contains UI/config:"
Add-Line "- Contains OCR/image/color/coordinate:"
Add-Line "- Contains flow/condition/listener:"
Add-Line "- Contains environment/emulator issue:"
Add-Line "- Sensitive content:"
Add-Line
Add-Line "## Summary"
Add-Line
Add-Line "Problem pattern:"
Add-Line
Add-Line "Recommended public explanation:"
Add-Line
Add-Line "Important limits:"
Add-Line
Add-Line "Common failure mode:"
Add-Line
Add-Line "## Code And Architecture"
Add-Line
Add-Line "Public-safe pattern:"
Add-Line
Add-Line "Pseudo-code or short sanitized snippet:"
Add-Line
Add-Line $fence
Add-Line
Add-Line $fence
Add-Line
Add-Line "What must not be copied:"
Add-Line
Add-Line "- Full unauthorized source code:"
Add-Line "- Real token/key/cookie:"
Add-Line "- License algorithm:"
Add-Line "- Admin URL:"
Add-Line "- Abuse/bypass steps:"
Add-Line
Add-Line "## Auto Wizard Architecture Mapping"
Add-Line
Add-Line "- Variables/storage:"
Add-Line "- Actions/expressions:"
Add-Line "- OCR/image/color:"
Add-Line "- Node/control tree:"
Add-Line "- File/log/network:"
Add-Line "- UI/config:"
Add-Line "- Backend/deployment:"
Add-Line "- Error recovery:"
Add-Line
Add-Line "## Wanlong Script Use"
Add-Line
Add-Line "- Useful for Wanlong:"
Add-Line "- Target state:"
Add-Line "- Target action:"
Add-Line "- Test screenshot needed:"
Add-Line "- Failure recovery:"
Add-Line "- Log fields:"
Add-Line
Add-Line "## Writeback"
Add-Line
Add-Line "- Topic note updated:"
Add-Line "- Tutorial map updated:"
Add-Line "- Category 3 coverage updated:"
Add-Line "- Category 4 continuation updated:"
Add-Line "- Study queue updated:"
Add-Line "- Safety review done:"
Add-Line
Add-Line "## Decision"
Add-Line
Add-Line "- Status: $Status"
Add-Line "- Exclusion reason:"
Add-Line "- Follow-up:"

Set-Content -LiteralPath $outputPath -Value ($lines -join [Environment]::NewLine) -Encoding utf8

[ordered]@{
    output = $outputPath
    thread_id = $ThreadId
    category_id = $CategoryId
    status = $Status
    url = $sourceUrl
} | ConvertTo-Json -Depth 4
