# Deep Read: 803 Weekday Condition Tutorial

## Source

- Thread ID: 803
- Category: 3
- URL: https://bbs.zdjl.site/#/thread/detail/803
- Created at: 2021-07-31T06:29:16.000Z
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

- Primary topic: weekday run condition
- Secondary topics: Date expression, beginner condition, system prompt
- Contains code: yes
- Contains setup/deployment: no
- Contains backend/API: no
- Contains UI/config: yes
- Contains OCR/image/color/coordinate: no
- Contains flow/condition/listener: yes
- Contains environment/emulator issue: no
- Sensitive content: no

## Summary

Problem pattern: A script needs to run different branches depending on the day of week.

Recommended public explanation: `Date.getDay()` returns 0 through 6, with 0 as Sunday; attach different run conditions to different actions.

Important limits: Phone date/time settings affect the result, so tests should use known dates.

Common failure mode: Treating 7 as Sunday instead of 0.

## Code And Architecture

Public-safe pattern: Map weekday number to a task branch.

```text
weekday = get_day()
if weekday == target_day:
  run_weekly_task()
```

What must not be copied:

- Full unauthorized source code: yes
- Real token/key/cookie: yes
- License algorithm: yes
- Admin URL: yes
- Abuse/bypass steps: yes

## Auto Wizard Architecture Mapping

- Variables/storage: weekday, selected weekly task.
- Actions/expressions: JS expression as run condition.
- OCR/image/color: not relevant.
- Node/control tree: not relevant.
- File/log/network: log which weekday branch ran.
- UI/config: let user select weekly schedule.
- Backend/deployment: not relevant.
- Error recovery: fallback branch when no weekday matches.

## Wanlong Script Use

- Useful for Wanlong: yes
- Target state: schedule_router
- Target action: choose weekly activity flow
- Test screenshot needed: no
- Failure recovery: default to safe idle if no branch matches
- Log fields: weekday, target_day, selected_flow

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
- Follow-up: Combine with daily and cross-day time window notes.
