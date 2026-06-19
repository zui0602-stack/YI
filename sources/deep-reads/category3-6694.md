# Deep Read: 6694 Scheduled Script Run

## Source

- Thread ID: 6694
- Category: 3
- URL: https://bbs.zdjl.site/#/thread/detail/6694
- Created at: 2022-08-19T07:04:35.702Z
- Read at: 2026-06-19 Asia/Taipei
- Reader: Codex browser-fetch
- Raw file: Browser/API fetch reviewed; raw JSON not published
- Posts file: Browser/API posts list reviewed; raw JSON not published

## Access Check

- Page/API opened successfully: yes, thread API and posts API opened with browser-style request
- Not a 504/blank/error page: yes
- Main post reviewed: yes
- Replies reviewed: yes, first page replies reviewed
- Images reviewed: yes, image references reviewed from post metadata; media not republished
- Video or attachment checked: yes, no public media copied

## Classification

- Primary topic: scheduled run condition
- Secondary topics: time window, repeat check, whole-hour trigger
- Contains code: yes
- Contains setup/deployment: no
- Contains backend/API: no
- Contains UI/config: yes
- Contains OCR/image/color/coordinate: no
- Contains flow/condition/listener: yes
- Contains environment/emulator issue: no
- Sensitive content: no

## Summary

Problem pattern: Auto Wizard may not have a separate scheduler, but a script can wait at the first action until a time condition becomes true.

Recommended public explanation: Combine a lower bound and an upper bound so the script only enters during a narrow time window, and enable repeated checking.

Important limits: This does not start the script by itself; the script must already be running and waiting.

Common failure mode: Using only "after 18:20" also passes at 20:00, so the upper bound is needed.

## Code And Architecture

Public-safe pattern: Treat schedule as a gate before the main state machine.

```text
if now >= start_time and now <= end_time:
  enter_main_flow()
else:
  keep_waiting()
```

What must not be copied:

- Full unauthorized source code: yes
- Real token/key/cookie: yes
- License algorithm: yes
- Admin URL: yes
- Abuse/bypass steps: yes

## Auto Wizard Architecture Mapping

- Variables/storage: store start/end time or whole-hour mode.
- Actions/expressions: run condition before first real action.
- OCR/image/color: not relevant.
- Node/control tree: not relevant.
- File/log/network: log when the gate opens.
- UI/config: expose time fields in settings.
- Backend/deployment: not relevant.
- Error recovery: if time window missed, loop back to waiting state.

## Wanlong Script Use

- Useful for Wanlong: yes
- Target state: waiting_for_activity_window
- Target action: enter gather/search flow only inside allowed time
- Test screenshot needed: no
- Failure recovery: log skipped window and next check time
- Log fields: schedule_start, schedule_end, current_time, gate_result

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
- Follow-up: Cross-link with time controller and cross-day time-window notes.
