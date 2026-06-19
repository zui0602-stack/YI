# Deep Read: 17748 JS 基礎語法

## Source

- Thread ID: 17748
- Category: 3
- URL: https://bbs.zdjl.site/#/thread/detail/17748
- Created at: 2024-06-22T09:28:51.394Z
- Read at: 2026-06-18 Asia/Taipei
- Reader: Codex browser-fetch
- Raw file: Browser/API fetch reviewed; raw JSON not published
- Posts file: Browser/API posts list reviewed; raw JSON not published

## Access Check

- Page/API opened successfully: yes, thread API and posts API opened with browser-style request
- Not a 504/blank/error page: yes
- Main post reviewed: yes
- Replies reviewed: yes
- Images reviewed: not applicable
- Video or attachment checked: not applicable

## Classification

- Primary topic: JavaScript basics
- Secondary topics: variables, constants, scope, syntax foundation
- Contains code: yes
- Contains setup/deployment: no
- Contains backend/API: no
- Contains UI/config: no
- Contains OCR/image/color/coordinate: no
- Contains flow/condition/listener: yes
- Contains environment/emulator issue: no
- Sensitive content: no

## Summary

Problem pattern: New Auto Wizard users need enough JavaScript vocabulary to understand JS actions, expressions, variables, and snippets.

Recommended public explanation: Use `let` and `const` for most script logic, understand scope before mixing UI variables and JS variables, and avoid accidental globals in long-running automation.

Important limits: This is language foundation, not Auto Wizard API coverage by itself.

Common failure mode: Copying JS snippets without understanding variable scope, reassignment, or object mutation.

## Code And Architecture

Public-safe pattern: Keep snippets short and explain why the variable is mutable or constant.

Pseudo-code or short sanitized snippet:

```text
const config = read_config_once()
let state = current_task_state
state = next_state_after_detection(state)
```

What must not be copied:

- Full unauthorized source code: yes
- Real token/key/cookie: yes
- License algorithm: yes
- Admin URL: yes
- Abuse/bypass steps: yes

## Auto Wizard Architecture Mapping

- Variables/storage: JS variables should map clearly to Auto Wizard global variables.
- Actions/expressions: JS expressions are safe only when scope and type are understood.
- OCR/image/color: not relevant.
- Node/control tree: not relevant.
- File/log/network: not relevant.
- UI/config: use constants for fixed config and variables for state.
- Backend/deployment: not relevant.
- Error recovery: avoid ReferenceError from block-scope mistakes.

## Wanlong Script Use

- Useful for Wanlong: yes
- Target state: JS foundation for state machine and config code
- Target action: use `const` for fixed thresholds and `let` for changing task state
- Test screenshot needed: no
- Failure recovery: log undefined variables before action execution
- Log fields: variable_name, variable_type, state

## Writeback

- Topic note updated: yes, docs/category-3-source-00-deep-read.md
- Tutorial map updated: pending
- Category 3 coverage updated: yes
- Category 4 continuation updated: not applicable
- Study queue updated: yes
- Safety review done: yes

## Decision

- Status: specialized
- Exclusion reason:
- Follow-up: Fold core JS rules into API cheatsheet later.

