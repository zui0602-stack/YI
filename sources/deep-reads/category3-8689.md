# Deep Read: 8689 Two-Level Linked Menu

## Source

- Thread ID: 8689
- Category: 3
- URL: https://bbs.zdjl.site/#/thread/detail/8689
- Created at: 2022-11-16T16:00:37.361Z
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
- Video or attachment checked: yes, example script reference not copied

## Classification

- Primary topic: linked menu UI
- Secondary topics: nested arrays, dynamic option list, initial values
- Contains code: yes
- Contains setup/deployment: no
- Contains backend/API: no
- Contains UI/config: yes
- Contains OCR/image/color/coordinate: no
- Contains flow/condition/listener: yes
- Contains environment/emulator issue: no
- Sensitive content: no

## Summary

Problem pattern: A second menu should change options based on the first menu's selected value.

Recommended public explanation: Store top-level options and nested child options separately, then use the selected top-level index to choose the child list.

Important limits: Initialize dependent variables before they are referenced, or the dialog can fail.

Common failure mode: Defining a nested array as a plain character array, causing child options to be treated as strings.

## Code And Architecture

Public-safe pattern: Linked options with initial values.

```text
groups = [...]
items = [[...], [...]]
selected_group = groups[0]
item_options = items[index_of(groups, selected_group)]
```

What must not be copied:

- Full unauthorized source code: yes
- Real token/key/cookie: yes
- License algorithm: yes
- Admin URL: yes
- Abuse/bypass steps: yes

## Auto Wizard Architecture Mapping

- Variables/storage: groups, nested item arrays, selected values.
- Actions/expressions: option list expression and index lookup.
- OCR/image/color: not relevant.
- Node/control tree: not relevant.
- File/log/network: log selected configuration.
- UI/config: linked menu, resource selector, hero/team selector.
- Backend/deployment: not relevant.
- Error recovery: validate selected group and child list before showing.

## Wanlong Script Use

- Useful for Wanlong: yes
- Target state: linked_config_menu
- Target action: choose resource category then resource type, or team then hero
- Test screenshot needed: yes, config dialog
- Failure recovery: reset to first valid option
- Log fields: selected_group, selected_item, child_options_count

## Writeback

- Topic note updated: yes, docs/category-3-c3-03-deep-read.md
- Tutorial map updated: pending
- Category 3 coverage updated: yes
- Category 4 continuation updated: not applicable
- Study queue updated: yes
- Safety review done: yes

## Decision

- Status: specialized
- Exclusion reason:
- Follow-up: Merge with linked menu assignment note 8727.
