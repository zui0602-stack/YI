# Deep Read: 22969 Dialog Default Branch

## Source

- Thread ID: 22969
- Category: 3
- URL: https://bbs.zdjl.site/#/thread/detail/22969
- Created at: 2025-10-24T09:47:26.313Z
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
- Video or attachment checked: yes, downloadable script reference not copied

## Classification

- Primary topic: dialog timeout default action
- Secondary topics: multiple buttons, jump labels, fallback branch
- Contains code: no
- Contains setup/deployment: no
- Contains backend/API: no
- Contains UI/config: yes
- Contains OCR/image/color/coordinate: no
- Contains flow/condition/listener: yes
- Contains environment/emulator issue: no
- Sensitive content: no

## Summary

Problem pattern: A script asks the user to choose, but unattended operation needs a safe default after timeout.

Recommended public explanation: Set dialog display time, wire each button to a jump label, and place a default jump immediately after the dialog.

Important limits: The default action should be the safest branch, not the most destructive branch.

Common failure mode: Forgetting to label the target actions, so button and timeout branches land in the wrong place.

## Code And Architecture

Public-safe pattern: Human choice with fallback.

```text
show_dialog(timeout=60, buttons=[A, B])
if clicked_A: jump(A)
if clicked_B: jump(B)
if timeout: jump(default_safe_branch)
```

What must not be copied:

- Full unauthorized source code: yes
- Real token/key/cookie: yes
- License algorithm: yes
- Admin URL: yes
- Abuse/bypass steps: yes

## Auto Wizard Architecture Mapping

- Variables/storage: selected option, timeout, default branch.
- Actions/expressions: dialog action plus jump labels.
- OCR/image/color: not relevant.
- Node/control tree: not relevant.
- File/log/network: log which branch was selected.
- UI/config: expose default behavior.
- Backend/deployment: not relevant.
- Error recovery: fall back to safe branch after timeout.

## Wanlong Script Use

- Useful for Wanlong: yes
- Target state: user_confirmation_or_default
- Target action: ask whether to retry/return/stop, default to safe return
- Test screenshot needed: yes, dialog state
- Failure recovery: default branch should avoid spending resources
- Log fields: dialog_name, selected_branch, timeout_used

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
- Follow-up: Add to UI/config notes as default branch pattern.
