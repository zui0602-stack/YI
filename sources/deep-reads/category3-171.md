# Deep Read: 171 Run Count Statistics

## Source

- Thread ID: 171
- Category: 3
- URL: https://bbs.zdjl.site/#/thread/detail/171
- Created at: 2021-05-07T14:33:00.000Z
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

- Primary topic: run count statistics
- Secondary topics: variable increment, action success listener, screen prompt
- Contains code: no
- Contains setup/deployment: no
- Contains backend/API: no
- Contains UI/config: yes
- Contains OCR/image/color/coordinate: no
- Contains flow/condition/listener: yes
- Contains environment/emulator issue: no
- Sensitive content: no

## Summary

Problem pattern: Users need a simple counter that records how many times a target action has succeeded.

Recommended public explanation: Initialize a variable, attach a success listener to the action, increment the variable on success, and show or log the current count.

Important limits: Count only after confirmed success, not before the action starts.

Common failure mode: Incrementing inside the main loop without checking success, producing false counts.

## Code And Architecture

Public-safe pattern: Listener-driven counters are better than unconditional loop counters.

Pseudo-code or short sanitized snippet:

```text
count = 0
on action_success:
  count = count + 1
  show(count)
```

What must not be copied:

- Full unauthorized source code: yes
- Real token/key/cookie: yes
- License algorithm: yes
- Admin URL: yes
- Abuse/bypass steps: yes

## Auto Wizard Architecture Mapping

- Variables/storage: store `count` in appropriate scope.
- Actions/expressions: listener increments after success.
- OCR/image/color: not relevant.
- Node/control tree: not relevant.
- File/log/network: optional persistent run log.
- UI/config: prompt or overlay count.
- Backend/deployment: not relevant.
- Error recovery: reset or persist count intentionally.

## Wanlong Script Use

- Useful for Wanlong: yes
- Target state: collection round and retry counting
- Target action: increment after gather action succeeds
- Test screenshot needed: no
- Failure recovery: separate success_count and failure_count
- Log fields: success_count, failure_count, action_name

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
- Follow-up: Add counters to Wanlong logging schema.
