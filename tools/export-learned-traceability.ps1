param(
    [string]$CoveragePath = "sources/category-3-topic-coverage.md",
    [string]$OutputPath = "sources/learned-thread-traceability.json"
)

$ErrorActionPreference = "Stop"

$root = (Resolve-Path -LiteralPath (Join-Path $PSScriptRoot "..")).Path
Push-Location $root
try {
    if (-not (Test-Path -LiteralPath $CoveragePath)) {
        throw "Coverage file not found: $CoveragePath"
    }

    $text = Get-Content -Raw -Encoding utf8 -LiteralPath $CoveragePath
    $documentRows = New-Object System.Collections.Generic.List[object]
    $allIds = New-Object System.Collections.Generic.List[int]

    foreach ($line in ($text -split "`r?`n")) {
        if ($line -notmatch '^\|\s*<code>([^<]+)</code>\s*\|\s*([0-9]+)\s*\|\s*([^|]+)\|') {
            continue
        }

        $docPath = $matches[1].Trim()
        $declaredCount = [int]$matches[2]
        $idText = $matches[3]
        $ids = @([regex]::Matches($idText, '\d+') | ForEach-Object { [int]$_.Value })

        foreach ($id in $ids) {
            $allIds.Add($id) | Out-Null
        }

        $documentRows.Add([pscustomobject]@{
            document = $docPath
            declared_count = $declaredCount
            parsed_count = $ids.Count
            ids = $ids
            count_matches = ($declaredCount -eq $ids.Count)
        }) | Out-Null
    }

    $uniqueIds = @($allIds.ToArray() | Sort-Object -Unique)
    $duplicateIds = @(
        $allIds.ToArray() |
            Group-Object |
            Where-Object { $_.Count -gt 1 } |
            ForEach-Object {
                [pscustomobject]@{
                    id = [int]$_.Name
                    references = $_.Count
                }
            } |
            Sort-Object id
    )

    $documentsWithCountMismatch = @(
        $documentRows.ToArray() |
            Where-Object { -not $_.count_matches } |
            Select-Object document, declared_count, parsed_count
    )

    $result = [pscustomobject]@{
        generated_at = (Get-Date -Format s)
        purpose = "Traceability from learned topic documents to Category 3 thread IDs. This is generated from sources/category-3-topic-coverage.md."
        rules = @(
            "Already learned threads do not need date backfill.",
            "Each specialized thread should be traceable to at least one docs/*.md topic document.",
            "Duplicate references are expected when one thread informs multiple topics."
        )
        source = $CoveragePath
        expected_specialized_count = 177
        document_count = $documentRows.Count
        unique_thread_count = $uniqueIds.Count
        total_references = $allIds.Count
        unique_thread_count_matches_expected = ($uniqueIds.Count -eq 177)
        documents_with_count_mismatch = $documentsWithCountMismatch
        duplicate_thread_references = $duplicateIds
        documents = $documentRows
        unique_thread_ids = $uniqueIds
    }

    $result | ConvertTo-Json -Depth 12 | Set-Content -LiteralPath $OutputPath -Encoding utf8
    $result | ConvertTo-Json -Depth 12
}
finally {
    Pop-Location
}
