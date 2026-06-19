# Deep Read Ledger

This ledger tracks batch-level reading work. It does not replace topic notes or source coverage tables.

## Current State

| Area | Status |
|---|---|
| Category 3 manifest | 309 / 309 indexed |
| Category 3 opened audit | 309 / 309 opened in prior audit |
| Category 3 specialized | 177 |
| Category 3 source-summary only | 0 |
| Category 3 not yet specialized | 132 |
| Category 4 valid range | Paused by user request on 2026-06-18 |
| Local verification | `tools/verify-learning-library.ps1` passes |
| Forum verification | 2026-06-19 c3-04 retry currently returns 504/connection errors; see `sources/category-3-c3-04-access-log.md` |

## Required Templates

- Per-thread record: `templates/deep-read-note.md`
- Batch report: `templates/batch-review-report.md`
- Protocol: `docs/deep-read-protocol.md`

## Batch Ledger

| Batch | Category | Planned | Done | Status | Evidence |
|---|---:|---:|---:|---|---|
| source-00 | 3 | 11 | 11 | specialized | `docs/category-3-source-00-deep-read.md`, `sources/deep-reads/category3-*.md` |
| c3-01 | 3 | 20 | 20 | specialized | `docs/category-3-c3-01-deep-read.md`, `sources/deep-reads/category3-*.md` |
| c3-02 | 3 | 20 | 20 | specialized | `docs/category-3-c3-02-deep-read.md`, `sources/deep-reads/category3-*.md` |
| c3-03 | 3 | 20 | 20 | specialized | `docs/category-3-c3-03-deep-read.md`, `sources/deep-reads/category3-*.md` |
| c3-04 | 3 | 20 | 0 | pending source access | `sources/category-3-continuation-plan.md`, `sources/category-3-c3-04-access-log.md` |
| c3-05 | 3 | 20 | 0 | pending | `sources/category-3-continuation-plan.md` |
| c3-06 | 3 | 20 | 0 | pending | `sources/category-3-continuation-plan.md` |
| c3-07 | 3 | 20 | 0 | pending | `sources/category-3-continuation-plan.md` |
| c3-08 | 3 | 20 | 0 | pending | `sources/category-3-continuation-plan.md` |
| c3-09 | 3 | 20 | 0 | pending | `sources/category-3-continuation-plan.md` |
| c3-10 | 3 | 12 | 0 | pending | `sources/category-3-continuation-plan.md` |
| c4-topic-next | 4 | TBD | 0 | paused by user request | `sources/category-4-continuation-plan.md` |

## Completion Rule

Do not mark a batch done unless:

1. Every planned thread has a per-thread result.
2. Topic notes are updated.
3. Sensitive content is reviewed.
4. Continuation and coverage files are updated.
5. `tools/verify-learning-library.ps1` passes.
