# Contributing

This repository is a public-safe learning library for Auto Wizard tutorials, forum Q&A, and related script architecture notes.

The goal is traceability: every learned tutorial should have a source ID, a deep-read record, a public-safe summary, a topic note, and a verification result.

## Scope Rules

- Category 3 is fully in scope: all 309 tutorial threads must be tracked.
- Category 4 is in scope only when `created_at >= 2024-01-01`.
- Category 4 replies must use the same date rule unless the reply is needed only to explain why a thread is excluded.
- Any tutorial, setup, API, code, deployment, UI, OCR, image recognition, emulator, or debugging content should be classified.
- Old category 4 posts before 2024 are excluded unless they are already represented by a newer tutorial source.

## What Counts As Learned

A thread is not learned just because it appears in a manifest.

Before a thread can be counted as learned:

1. The source page or API response must be readable.
2. The main post must be reviewed.
3. Replies, images, videos, and attachments must be checked or marked unavailable.
4. Code must be summarized safely instead of copied wholesale.
5. Setup, backend, API, and deployment ideas must be mapped to public-safe architecture notes.
6. A topic note under `docs/` must be updated.
7. The coverage or continuation plan under `sources/` must be updated.
8. Local verification must pass.

Use `templates/deep-read-note.md` for each thread and `templates/batch-review-report.md` after each batch.

## Safety Rules

Do not publish:

- Full unauthorized source code from forum posts.
- Real API keys, tokens, cookies, passwords, or private credentials.
- Card/license algorithms or bypass logic.
- Admin URLs, private backend endpoints, or operational secrets.
- Ad fraud, captcha bypass, account abuse, or verification-circumvention steps.
- Raw forum dumps or media files without review.

Prefer:

- Short sanitized snippets.
- Pseudo-code.
- Architecture diagrams or summaries.
- Fake example values.
- Failure modes and recovery patterns.

## Working A Batch

1. Confirm the forum is reachable with `tools/probe-zdjl-forum.ps1`.
2. Sync only the required sources with `tools/sync-zdjl-forum.ps1`.
3. Build or refresh the queue with `tools/build-study-queue.ps1`.
4. Create one deep-read note per thread with `tools/new-deep-read-note.ps1`.
5. Update topic notes and coverage files.
6. Run `tools/verify-deep-read-records.ps1`.
7. Run `tools/verify-learning-library.ps1`.

If the forum is unavailable, do not mark unread threads as learned. Record the blocked state in the continuation plan instead.

## GitHub Review Checklist

Before publishing:

- `tools/verify-learning-library.ps1` passes.
- `tools/verify-deep-read-records.ps1` passes.
- `sources/raw/`, `sources/raw-*`, and `tmp/` are not included.
- No real credentials or private endpoints are present.
- No copyrighted forum post is copied in full.
- Remaining work is visible in `docs/completion-audit.md`, `docs/progress-dashboard.md`, and `sources/deep-read-ledger.md`.

