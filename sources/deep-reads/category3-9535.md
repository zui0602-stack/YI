# Deep Read: 9535 Control Run Jump Semantics

## Source

- Thread ID: 9535
- Category: 3
- URL: https://bbs.zdjl.site/#/thread/detail/9535
- Created at: 2023-01-04T09:29:39.619Z
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

- Primary topic: control flow jump
- Secondary topics: main list, sub list, multi-action, listener, labels
- Contains code: no
- Contains setup/deployment: no
- Contains backend/API: no
- Contains UI/config: yes
- Contains OCR/image/color/coordinate: no
- Contains flow/condition/listener: yes
- Contains environment/emulator issue: no
- Sensitive content: no

## Summary

Problem pattern: Users often misunderstand whether a jump targets the main action list or the current multi-action sub-list.

Recommended public explanation: Plain numeric jumps and `+/-` offsets target the main list. The `&` form is for jumping inside the current multi-action context. Named labels work in main and sub actions, but listener contexts need careful testing.

Important limits: Jump behavior depends on where the action runs. A listener nested inside another action should not be treated like a normal linear step.

Common failure mode: Creating a loop in the wrong list and wondering why the sub-action never exits.

## Code And Architecture

Public-safe pattern: Document every jump target as either main-list, sub-list, or label.

Pseudo-code or short sanitized snippet:

```text
main: goto +2      # main list offset
multi: goto &+1    # current multi-action offset
goto label_ready   # named transition
```

What must not be copied:

- Full unauthorized source code: yes
- Real token/key/cookie: yes
- License algorithm: yes
- Admin URL: yes
- Abuse/bypass steps: yes

## Auto Wizard Architecture Mapping

- Variables/storage: store loop counters to prevent infinite jumps.
- Actions/expressions: use jump labels only with clear scope.
- OCR/image/color: detectors should set explicit branch outcomes.
- Node/control tree: not relevant.
- File/log/network: log jump target and current scope.
- UI/config: expose max retry loops.
- Backend/deployment: not relevant.
- Error recovery: always include an escape label.

## Wanlong Script Use

- Useful for Wanlong: yes
- Target state: main state machine and nested recovery actions
- Target action: route from search, target found, gather, no resource, and home states
- Test screenshot needed: no, but flow tests are needed
- Failure recovery: use scoped labels and max retries
- Log fields: current_scope, jump_target, retry_count, exit_reason

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
- Follow-up: Add examples to flow-control docs.
