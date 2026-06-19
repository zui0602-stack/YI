# Deep Read: 8727 Linked Menu Variable Assignment

## Source

- Thread ID: 8727
- Category: 3
- URL: https://bbs.zdjl.site/#/thread/detail/8727
- Created at: 2022-11-18T07:54:31.732Z
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
- Video or attachment checked: yes, example link not copied

## Classification

- Primary topic: linked menu configuration
- Secondary topics: nested arrays, indexOf, coordinate/config mapping
- Contains code: yes
- Contains setup/deployment: no
- Contains backend/API: no
- Contains UI/config: yes
- Contains OCR/image/color/coordinate: yes
- Contains flow/condition/listener: yes
- Contains environment/emulator issue: no
- Sensitive content: no

## Summary

Problem pattern: A UI selection should map to a corresponding coordinate or configuration value.

Recommended public explanation: Store menu options and values in parallel nested arrays; use the selected option index to retrieve the matching value.

Important limits: Selection value and array entry must match exactly; missing values need a fallback.

Common failure mode: Using the wrong index level in nested arrays.

## Code And Architecture

Public-safe pattern: Linked menu to value lookup.

```text
team_index = teams.indexOf(selected_team)
person_index = persons[team_index].indexOf(selected_person)
coord = coords[team_index][person_index]
```

What must not be copied:

- Full unauthorized source code: yes
- Real token/key/cookie: yes
- License algorithm: yes
- Admin URL: yes
- Abuse/bypass steps: yes

## Auto Wizard Architecture Mapping

- Variables/storage: option arrays, value arrays, selected values.
- Actions/expressions: index lookup and value assignment.
- OCR/image/color: mapped values can be coordinates or regions.
- Node/control tree: not relevant.
- File/log/network: log selected path and resolved value.
- UI/config: linked menu, profile selector, resource selector.
- Backend/deployment: not relevant.
- Error recovery: validate indexes before using result.

## Wanlong Script Use

- Useful for Wanlong: yes
- Target state: config_router
- Target action: choose hero/team/resource and resolve matching coordinate/config
- Test screenshot needed: no
- Failure recovery: if selected value missing, stop and show config error
- Log fields: selected_group, selected_item, resolved_value, lookup_status

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
- Follow-up: Add to UI/config notes as linked menu mapping pattern.
