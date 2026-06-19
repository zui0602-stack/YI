# Deep Read: 21730 Account Switcher Logic

## Source

- Thread ID: 21730
- Category: 3
- URL: https://bbs.zdjl.site/#/thread/detail/21730
- Created at: 2025-06-10T11:03:11.413Z
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

- Primary topic: array-driven account rotation
- Secondary topics: index variable, stop condition, text click
- Contains code: yes
- Contains setup/deployment: no
- Contains backend/API: no
- Contains UI/config: yes
- Contains OCR/image/color/coordinate: no
- Contains flow/condition/listener: yes
- Contains environment/emulator issue: no
- Sensitive content: yes, credentials/account switching require authorization

## Summary

Problem pattern: A repeated workflow can move through a list by storing an array and a current index.

Recommended public explanation: Treat the account list as a generic config list; after each iteration increment the index and stop when it reaches the list length.

Important limits: Do not store or publish real usernames, passwords, session data, or unauthorized login automation.

Common failure mode: Off-by-one errors because user-facing account number starts at 1 while arrays start at 0.

## Code And Architecture

Public-safe pattern: Generic list rotation.

```text
item = items[current_index]
run_item_flow(item)
current_index += 1
if current_index >= items.length:
  stop()
```

What must not be copied:

- Full unauthorized source code: yes
- Real token/key/cookie: yes
- License algorithm: yes
- Admin URL: yes
- Abuse/bypass steps: yes

## Auto Wizard Architecture Mapping

- Variables/storage: item list, current index, max count.
- Actions/expressions: extract array item and increment index.
- OCR/image/color: optional for verifying selected item.
- Node/control tree: click known text only on authorized UI.
- File/log/network: do not log secrets.
- UI/config: allow selecting which config item to start from.
- Backend/deployment: not relevant.
- Error recovery: stop on login failure; do not keep guessing credentials.

## Wanlong Script Use

- Useful for Wanlong: limited
- Target state: multi_profile_router
- Target action: rotate safe local profiles or team configs
- Test screenshot needed: yes, only if UI selection is used
- Failure recovery: stop on selection mismatch or missing item
- Log fields: profile_index, profile_label, selection_result

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
- Follow-up: Reuse as list-iteration pattern, not credential automation.
