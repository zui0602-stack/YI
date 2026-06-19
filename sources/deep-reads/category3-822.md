# Deep Read: 822 Time Difference

## Source

- Thread ID: 822
- Category: 3
- URL: https://bbs.zdjl.site/#/thread/detail/822
- Created at: 2021-08-02T08:37:06.000Z
- Read at: 2026-06-19 Asia/Taipei
- Reader: Codex browser-fetch
- Raw file: Browser/API fetch reviewed; raw JSON not published
- Posts file: Browser/API posts list reviewed; raw JSON not published

## Access Check

- Page/API opened successfully: yes
- Not a 504/blank/error page: yes
- Main post reviewed: yes
- Replies reviewed: yes, first page replies reviewed
- Images reviewed: yes, image references reviewed from post metadata; media not republished
- Video or attachment checked: yes, no public media copied

## Classification

- Primary topic: elapsed time measurement
- Secondary topics: Date object, start/end time, local time display
- Contains code: yes
- Contains setup/deployment: no
- Contains backend/API: no
- Contains UI/config: yes
- Contains OCR/image/color/coordinate: no
- Contains flow/condition/listener: yes
- Contains environment/emulator issue: no
- Sensitive content: no

## Summary

Problem pattern: A script needs to know how long an action or full run took.

Recommended public explanation: Store start time, store end time, subtract timestamps, and format the result for logs or prompts.

Important limits: Device clock changes can distort elapsed time.

Common failure mode: Comparing formatted clock strings instead of numeric timestamps.

## Code And Architecture

Public-safe pattern: Use timestamps for calculation and formatted text only for display.

```text
start_ms = now()
run_task()
elapsed_ms = now() - start_ms
log(elapsed_ms)
```

What must not be copied:

- Full unauthorized source code: yes
- Real token/key/cookie: yes
- License algorithm: yes
- Admin URL: yes
- Abuse/bypass steps: yes

## Auto Wizard Architecture Mapping

- Variables/storage: start time, end time, elapsed seconds.
- Actions/expressions: Date expression and subtraction.
- OCR/image/color: not relevant.
- Node/control tree: not relevant.
- File/log/network: write elapsed time into logs.
- UI/config: show runtime in status panel.
- Backend/deployment: not relevant.
- Error recovery: use timeout if elapsed exceeds threshold.

## Wanlong Script Use

- Useful for Wanlong: yes
- Target state: runtime_monitor
- Target action: measure search/gather/retry duration
- Test screenshot needed: no
- Failure recovery: trigger stuck recovery if duration too long
- Log fields: state, start_ms, elapsed_ms, timeout_limit

## Writeback

- Topic note updated: yes, docs/category-3-c3-02-deep-read.md
- Tutorial map updated: pending
- Category 3 coverage updated: yes
- Category 4 continuation updated: not applicable
- Study queue updated: yes
- Safety review done: yes

## Decision

- Status: specialized
- Exclusion reason:
- Follow-up: Add to logging and performance notes.
