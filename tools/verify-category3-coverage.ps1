param(
    [string]$Root = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
)

$ErrorActionPreference = "Stop"

$manifestPath = Join-Path $Root "sources/category-3-full-manifest.md"
$coveragePath = Join-Path $Root "sources/category-3-topic-coverage.md"

if (-not (Test-Path $manifestPath)) {
    throw "Missing manifest: $manifestPath"
}
if (-not (Test-Path $coveragePath)) {
    throw "Missing coverage file: $coveragePath"
}

$manifest = Get-Content -Raw -Encoding utf8 $manifestPath
$manifestBlock = [regex]::Match($manifest, '```text\s*([\s\S]*?)```').Groups[1].Value
$manifestIds = @([regex]::Matches($manifestBlock, '\b\d+\b') | ForEach-Object { [int]$_.Value })

$coverage = Get-Content -Raw -Encoding utf8 $coveragePath
$coverageIds = @()
$blocks = @([regex]::Matches($coverage, '~~~text\s*([\s\S]*?)~~~'))
if ($blocks.Count -lt 3) {
    throw "Expected at least 3 coverage text blocks, found $($blocks.Count)"
}

foreach ($blockMatch in $blocks[0..2]) {
    $coverageIds += [regex]::Matches($blockMatch.Groups[1].Value, '\b\d+\b') | ForEach-Object { [int]$_.Value }
}

$missing = @($manifestIds | Where-Object { $_ -notin $coverageIds })
$extra = @($coverageIds | Where-Object { $_ -notin $manifestIds })
$duplicates = @($coverageIds | Group-Object | Where-Object { $_.Count -gt 1 } | ForEach-Object { [int]$_.Name })

$result = [ordered]@{
    manifest_count = $manifestIds.Count
    coverage_total = $coverageIds.Count
    coverage_unique = @($coverageIds | Select-Object -Unique).Count
    missing_count = $missing.Count
    extra_count = $extra.Count
    duplicate_count = $duplicates.Count
    missing = $missing
    extra = $extra
    duplicates = $duplicates
}

$result | ConvertTo-Json -Depth 5

if ($missing.Count -gt 0 -or $extra.Count -gt 0 -or $duplicates.Count -gt 0) {
    exit 1
}
