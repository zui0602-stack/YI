# Deep Read Protocol

This protocol defines what it means to "learn" one Auto Wizard forum thread before it can be counted as absorbed into the GitHub learning library.

## Why This Exists

The library must not only have links. Every useful tutorial, code example, deployment note, and answer needs a traceable path:

1. Source thread or reply.
2. Deep-read record.
3. Public-safe summary.
4. Topic note.
5. Coverage table or continuation plan.
6. Verification result.

If any step is missing, the thread is not fully learned yet.

## Per-thread Requirements

A thread is complete only when all required checks pass:

| Requirement | Evidence |
|---|---|
| Source opened | Browser page or API response is not 504/blank/error |
| Main post reviewed | Deep-read note records title, topic, and summary |
| Replies reviewed | Replies are checked when they contain corrections, missing details, or safety warnings |
| Media checked | Images, videos, and attachments are noted or marked unavailable |
| Code handled | Code is summarized, not copied wholesale |
| Deployment handled | Setup/backend/API details are mapped to safe architecture notes |
| Safety handled | Tokens, card/license details, admin URLs, and abuse steps are removed |
| Topic writeback | At least one `docs/*.md` topic note is updated |
| Source writeback | Coverage or continuation plan is updated |
| Verification | `tools/verify-learning-library.ps1` passes locally |

## Status Values

Use these status values consistently:

- `pending`: thread is known but not read yet.
- `opened`: page/API opened, but no summary has been written.
- `summarized`: deep-read note exists, but topic note not updated.
- `specialized`: topic note, map, and coverage were updated.
- `excluded`: reviewed and intentionally excluded with a reason.
- `blocked`: cannot read because forum, media, or attachment is unavailable.

## Category 3 Rule

Category 3 is the official tutorial area. All 309 threads are in scope.

For category 3, a thread can move out of "not yet specialized" only after:

- The source is readable.
- The thread is classified.
- A topic note is updated.
- `sources/category-3-topic-coverage.md` is updated.
- `tools/verify-category3-coverage.ps1` still reports no missing, extra, or duplicate IDs.

## Category 4 Rule

Category 4 is paused by user request on 2026-06-18.

- Do not add new Category 4 threads to the active learning queue.
- Existing Category 4 notes are historical references only.
- Completion is now judged against Category 3 active scope.

## Code Policy

Public GitHub content may include:

- Short sanitized snippets.
- Pseudo-code.
- Architecture explanation.
- API shape with fake values.
- Error-handling pattern.

Public GitHub content must not include:

- Full unauthorized source code.
- Real API keys, tokens, cookies, or passwords.
- Card/license algorithm details.
- Admin panels or private endpoints.
- Abuse, bypass, scraping, ad-fraud, or verification-circumvention steps.

## Video And Attachment Policy

Videos and attachments are not automatically copied into the repository.

For each media item, record:

- Whether it exists.
- Whether it is accessible.
- What topic it teaches.
- Whether it has code or setup details.
- Whether it needs permission before redistribution.

## Batch Completion

After each batch, create or update a batch report using `templates/batch-review-report.md`.

The batch is complete only when:

- Every planned ID has a result.
- Failed reads have error reasons.
- Topic notes are updated.
- Coverage and continuation files are updated.
- Local verification passes.
