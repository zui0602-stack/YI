# Deep Read: 10125 Practical Flow Control Cases

## Source

- Thread ID: 10125
- Category: 3
- URL: https://bbs.zdjl.site/#/thread/detail/10125
- Created at: 2023-02-02T06:49:06.036Z
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
- Video or attachment checked: not applicable

## Classification

- Primary topic: flow control cases
- Secondary topics: random image wait, jump labels, state memory, stuck detection, obstruction handling
- Contains code: yes
- Contains setup/deployment: no
- Contains backend/API: no
- Contains UI/config: yes
- Contains OCR/image/color/coordinate: yes
- Contains flow/condition/listener: yes
- Contains environment/emulator issue: no
- Sensitive content: no

## Summary

Problem pattern: Real scripts need more than one action; they need loops, conditions, labels, listeners, and recovery paths.

Recommended public explanation: Convert each uncertain screen event into a small state machine: wait for one of several known signals, run the matching action, jump to the next stable label, and persist state when needed.

Important limits: Do not rely on one full-screen detector forever. Enumerated image checks are workable only when the possible set is bounded.

Common failure mode: Adding repeat-until-success to multiple candidate actions and accidentally blocking later branches.

## Code And Architecture

Public-safe pattern: Use a label loop around candidate actions, and exit the loop only when one action succeeds.

Pseudo-code or short sanitized snippet:

```text
label A
if image_1: click_1; goto B
if image_2: click_2; goto B
goto A
label B
continue_next_step()
```

What must not be copied:

- Full unauthorized source code: yes
- Real token/key/cookie: yes
- License algorithm: yes
- Admin URL: yes
- Abuse/bypass steps: yes

## Auto Wizard Architecture Mapping

- Variables/storage: persist last successful state and retry counters.
- Actions/expressions: use action success listeners and jump labels.
- OCR/image/color: use bounded candidate detection with ROI when possible.
- Node/control tree: use node checks for app UI when available.
- File/log/network: log state transitions and stuck checks.
- UI/config: expose timeouts and retry limits.
- Backend/deployment: not relevant.
- Error recovery: define stuck, obstruction, and no-response branches.

## Wanlong Script Use

- Useful for Wanlong: yes
- Target state: collection search and gather flow state machine
- Target action: wait for known screen states, branch by detector, recover from obstruction
- Test screenshot needed: yes, each state image and stuck state
- Failure recovery: label-loop retry with max count and fallback to home/search
- Log fields: state, detector, retry_count, jump_target, last_success

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
- Follow-up: Fold core ideas into Wanlong virtual test state table.
