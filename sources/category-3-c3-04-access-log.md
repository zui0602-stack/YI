# Category 3 c3-04 Access Log

Source category: https://bbs.zdjl.site/#/thread/category/3

Checked at: 2026-06-19 Asia/Taipei

Scope note: Category 3 remains active. Category 4 remains paused by user request and was not read in this pass.

This file is an access and recovery log. It is not a deep-read result and it is not proof that c3-04 has been learned.

## Batch

| Thread ID | Page URL | API URL | Current status |
|---:|---|---|---|
| 17723 | https://bbs.zdjl.site/#/thread/detail/17723 | https://bbs.zdjl.site/bbs/threads/17723 | pending source reread |
| 20880 | https://bbs.zdjl.site/#/thread/detail/20880 | https://bbs.zdjl.site/bbs/threads/20880 | pending source reread |
| 19820 | https://bbs.zdjl.site/#/thread/detail/19820 | https://bbs.zdjl.site/bbs/threads/19820 | pending source reread |
| 547 | https://bbs.zdjl.site/#/thread/detail/547 | https://bbs.zdjl.site/bbs/threads/547 | pending source reread |
| 18034 | https://bbs.zdjl.site/#/thread/detail/18034 | https://bbs.zdjl.site/bbs/threads/18034 | pending source reread |
| 7819 | https://bbs.zdjl.site/#/thread/detail/7819 | https://bbs.zdjl.site/bbs/threads/7819 | pending source reread |
| 20593 | https://bbs.zdjl.site/#/thread/detail/20593 | https://bbs.zdjl.site/bbs/threads/20593 | pending source reread |
| 16774 | https://bbs.zdjl.site/#/thread/detail/16774 | https://bbs.zdjl.site/bbs/threads/16774 | pending source reread |
| 13280 | https://bbs.zdjl.site/#/thread/detail/13280 | https://bbs.zdjl.site/bbs/threads/13280 | pending source reread |
| 19666 | https://bbs.zdjl.site/#/thread/detail/19666 | https://bbs.zdjl.site/bbs/threads/19666 | pending source reread |
| 21083 | https://bbs.zdjl.site/#/thread/detail/21083 | https://bbs.zdjl.site/bbs/threads/21083 | pending source reread |
| 17676 | https://bbs.zdjl.site/#/thread/detail/17676 | https://bbs.zdjl.site/bbs/threads/17676 | pending source reread |
| 17694 | https://bbs.zdjl.site/#/thread/detail/17694 | https://bbs.zdjl.site/bbs/threads/17694 | pending source reread |
| 11207 | https://bbs.zdjl.site/#/thread/detail/11207 | https://bbs.zdjl.site/bbs/threads/11207 | pending source reread |
| 20884 | https://bbs.zdjl.site/#/thread/detail/20884 | https://bbs.zdjl.site/bbs/threads/20884 | pending source reread |
| 996 | https://bbs.zdjl.site/#/thread/detail/996 | https://bbs.zdjl.site/bbs/threads/996 | pending source reread |
| 14729 | https://bbs.zdjl.site/#/thread/detail/14729 | https://bbs.zdjl.site/bbs/threads/14729 | pending source reread |
| 860 | https://bbs.zdjl.site/#/thread/detail/860 | https://bbs.zdjl.site/bbs/threads/860 | pending source reread |
| 4673 | https://bbs.zdjl.site/#/thread/detail/4673 | https://bbs.zdjl.site/bbs/threads/4673 | pending source reread |
| 17258 | https://bbs.zdjl.site/#/thread/detail/17258 | https://bbs.zdjl.site/bbs/threads/17258 | pending source reread |

## Attempts

| Route | Result |
|---|---|
| Thread API: `https://bbs.zdjl.site/bbs/threads/17723` | HTTP 504 HTML page, title/body `504 Gateway Time-out`, server reported `nginx/1.14.1`. |
| Category page in Codex in-app browser: `https://bbs.zdjl.site/#/thread/category/3` | Navigation reached a `504 Gateway Time-out` page instead of the tutorial list. |
| PowerShell forum probe | Failed for category page, category API, and known thread checks with receive/connection errors. |
| User Chrome control path | Codex Chrome extension channel was unavailable in this environment, so the visible Chrome tab could not be inspected directly. |
| 2026-06-19 retry with `tools/probe-zdjl-forum.ps1 -TimeoutSec 8 -ThreadIds 17723` | Category page, category API, thread page, and thread API all failed with receive/connection errors. |
| Tool hardening check | `tools/sync-zdjl-forum-browser-fetch.mjs` now supports timeout, retry, skipped category listing, and direct c3 batch selection. Syntax was checked through the Codex JS parser because local `node` entry is blocked by the current sandbox path permissions. |

## Decision

- c3-04 is not marked learned.
- No c3-04 per-thread deep-read notes were created from unavailable source content.
- The active queue remains c3-04, then c3-05 through c3-10.
- The current public package should keep this as an incomplete external-source checkpoint.

## 2026-06-19 Remaining Date Scope Check

User asked whether the remaining Category 3 queue is all 2024-or-newer and can therefore be skipped.

Current evidence does not prove that. The saved queue has thread IDs but not complete `created_at` values for the 132 pending threads. A quick ID-position check shows mixed age:

- Pending Category 3 threads: 132.
- IDs below 16000: 97. These are likely older tutorial posts, often bumped by later replies.
- IDs 16000 or higher: 35. These are likely 2024-or-newer or near that range.
- Lowest pending IDs include: 133, 203, 215, 235, 547, 708, 712, 813, 847, 856.

Decision: do not bulk-skip the remaining 132 threads as 2024-or-newer. If the active rule becomes "skip 2024-or-newer Category 3 threads", first fetch or recover each pending thread's real `created_at` value, then exclude only threads proven to be on or after the chosen cutoff.

## Resume Rule

When the forum is reachable again:

1. Run this resumable c3-04 fetch command from a normal local shell:

   ```powershell
   node .\tools\sync-zdjl-forum-browser-fetch.mjs --skip-categories --c3-batch c3-04 --fetch-thread-details --fetch-posts --timeout-ms 25000 --retries 2 --retry-delay-ms 1500 --page-limit 100 --output-dir sources/raw-browser-c3-04
   ```

2. Build a local review packet from the raw JSON before writing final notes:

   ```powershell
   powershell -NoProfile -ExecutionPolicy Bypass -File .\tools\prepare-deep-read-review-from-raw.ps1 -Batch c3-04 -RawDir sources/raw-browser-c3-04 -OutputDir tmp\deep-read-review-c3-04
   ```

3. Open each thread API URL and the matching posts API:
   `https://bbs.zdjl.site/bbs/posts/list?thread_id=<id>&page_offset=0&page_limit=100&sort=created_at`
4. Review the main post, first-page replies, image metadata, video/attachment references, and any code snippets.
5. Create one `sources/deep-reads/category3-<id>.md` file per thread.
6. Add a c3-04 batch report under `docs/category-3-c3-04-deep-read.md`.
7. Update `sources/category-3-topic-coverage.md`, `sources/deep-read-ledger.md`, and generated queues.
8. Run the verification tools before counting c3-04 as completed.

## Safety

Raw forum JSON, full source posts, copied attachments, and private tokens are not stored in this repository.
