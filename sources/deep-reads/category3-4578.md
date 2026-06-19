# Deep Read: 4578 Swipe To Find Text Or Image

## Source

- Thread ID: 4578
- Category: 3
- URL: https://bbs.zdjl.site/#/thread/detail/4578
- Created at: 2022-04-29T02:42:44.616Z
- Read at: 2026-06-19 Asia/Taipei
- Reader: Codex browser-fetch
- Raw file: Browser/API fetch reviewed; raw JSON not published
- Posts file: Browser/API posts list reviewed; raw JSON not published

## Access Check

- Page/API opened successfully: yes
- Not a 504/blank/error page: yes
- Main post reviewed: yes
- Replies reviewed: yes, first page replies reviewed
- Images reviewed: yes, no media republished
- Video or attachment checked: yes, example script link not copied

## Classification

- Primary topic: scroll search loop
- Secondary topics: find text, find image, loop escape, module call
- Contains code: yes
- Contains setup/deployment: no
- Contains backend/API: no
- Contains UI/config: no
- Contains OCR/image/color/coordinate: yes
- Contains flow/condition/listener: yes
- Contains environment/emulator issue: no
- Sensitive content: no

## Summary

Problem pattern: A target text/image may be off-screen, so the script must search, scroll, and stop when found.

Recommended public explanation: Use a bounded or guarded loop: attempt to find target, click or mark success if found, otherwise swipe and retry.

Important limits: Infinite loops need max attempts or a stop condition for stability.

Common failure mode: Putting a long infinite search inside a single multi-action block where state changes do not exit cleanly.

## Code And Architecture

Public-safe pattern: Search loop with escape condition.

```text
for attempt in 1..max_attempts:
  if find_target():
    click_target()
    break
  swipe_next_page()
else:
  report_not_found()
```

What must not be copied:

- Full unauthorized source code: yes
- Real token/key/cookie: yes
- License algorithm: yes
- Admin URL: yes
- Abuse/bypass steps: yes

## Auto Wizard Architecture Mapping

- Variables/storage: attempt count, found flag, target text/image.
- Actions/expressions: loop module, condition, swipe.
- OCR/image/color: find text/image on each page.
- Node/control tree: use node text where available in normal apps.
- File/log/network: log attempts and final result.
- UI/config: target text and max attempts.
- Backend/deployment: not relevant.
- Error recovery: stop after max attempts or return to known screen.

## Wanlong Script Use

- Useful for Wanlong: yes
- Target state: scroll_search
- Target action: search list/event/mail/resource entries
- Test screenshot needed: yes, target absent/present pages
- Failure recovery: stop after max attempts and capture screenshot
- Log fields: target, attempt, found, swipe_count

## Writeback

- Topic note updated: yes, docs/category-3-c3-03-deep-read.md
- Tutorial map updated: pending
- Category 3 coverage updated: yes
- Category 4 continuation updated: not applicable
- Study queue updated: yes
- Safety review done: yes

## Decision

- Status: specialized
- Exclusion reason:
- Follow-up: Add bounded loop rule to flow notes.
