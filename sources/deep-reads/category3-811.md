# Deep Read: 811 Local Time Variables

## Source

- Thread ID: 811
- Category: 3
- URL: https://bbs.zdjl.site/#/thread/detail/811
- Created at: 2021-08-01T08:06:07.000Z
- Read at: 2026-06-18 Asia/Taipei
- Reader: Codex browser-fetch
- Raw file: Browser/API fetch reviewed; raw JSON not published
- Posts file: Browser/API posts list reviewed; raw JSON not published

## Access Check

- Page/API opened successfully: yes
- Not a 504/blank/error page: yes
- Main post reviewed: yes
- Replies reviewed: yes, first page replies reviewed
- Images reviewed: yes, screenshot references reviewed from post metadata; images not republished
- Video or attachment checked: yes, shared script link detected; package not republished

## Classification

- Primary topic: Date variables
- Secondary topics: new Date, year/month/day/hour/minute/second/week, text concatenation
- Contains code: yes
- Contains setup/deployment: no
- Contains backend/API: no
- Contains UI/config: yes
- Contains OCR/image/color/coordinate: no
- Contains flow/condition/listener: yes
- Contains environment/emulator issue: no
- Sensitive content: no

## Summary

Problem pattern: Scripts often need local time values for prompts, logs, filenames, or time-based conditions.

Recommended public explanation: Create a Date object once, then derive year, month, day, hour, minute, second, and weekday variables from it. When concatenating text, quote literal text and leave variable names unquoted.

Important limits: Month values in JavaScript Date APIs need careful checking because some methods are zero-based.

Common failure mode: Confusing the variable name with literal text, or forgetting to refresh the Date object.

## Code And Architecture

Public-safe pattern: Create a timestamp object and derive named fields.

Pseudo-code or short sanitized snippet:

```text
time = new Date()
year = time.getFullYear()
label = year + " year"
```

What must not be copied:

- Full unauthorized source code: yes
- Real token/key/cookie: yes
- License algorithm: yes
- Admin URL: yes
- Abuse/bypass steps: yes

## Auto Wizard Architecture Mapping

- Variables/storage: Date object and derived time fields.
- Actions/expressions: JS expressions for Date getters.
- OCR/image/color: not relevant.
- Node/control tree: not relevant.
- File/log/network: timestamp logs and filenames.
- UI/config: formatted prompt text.
- Backend/deployment: not relevant.
- Error recovery: regenerate time before comparisons.

## Wanlong Script Use

- Useful for Wanlong: yes
- Target state: logging, cooldowns, file naming, time display
- Target action: write timestamped logs and compare time windows
- Test screenshot needed: no
- Failure recovery: refresh Date object before branch
- Log fields: timestamp, year, month, day, hour, minute, second

## Writeback

- Topic note updated: yes, docs/category-3-c3-01-deep-read.md
- Tutorial map updated: pending
- Category 3 coverage updated: yes
- Category 4 continuation updated: not applicable
- Study queue updated: yes
- Safety review done: yes

## Decision

- Status: specialized
- Exclusion reason:
- Follow-up: Link with hourly time-window note.
