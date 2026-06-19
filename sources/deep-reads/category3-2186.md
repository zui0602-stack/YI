# Deep Read: 2186 JS 陣列搜尋

## Source

- Thread ID: 2186
- Category: 3
- URL: https://bbs.zdjl.site/#/thread/detail/2186
- Created at: 2021-12-05T04:09:44.407Z
- Read at: 2026-06-18 Asia/Taipei
- Reader: Codex browser-fetch
- Raw file: Browser/API fetch reviewed; raw JSON not published
- Posts file: Browser/API posts list reviewed; raw JSON not published

## Access Check

- Page/API opened successfully: yes
- Not a 504/blank/error page: yes
- Main post reviewed: yes
- Replies reviewed: yes
- Images reviewed: yes, image references seen but not redistributed
- Video or attachment checked: store link noted but not redistributed

## Classification

- Primary topic: array search
- Secondary topics: getVar, setVar, includes, loop
- Contains code: yes
- Contains setup/deployment: no
- Contains backend/API: no
- Contains UI/config: yes
- Contains OCR/image/color/coordinate: no
- Contains flow/condition/listener: yes
- Contains environment/emulator issue: no
- Sensitive content: no

## Summary

Problem pattern: A script has an array and needs to return items containing a keyword.

Recommended public explanation: Read array from Auto Wizard variable, iterate, push matching items to a result array, then write result back to a variable.

Important limits: `includes` is substring matching; exact matching needs equality or normalization.

Common failure mode: Searching `5` also matches `5.5` when using substring logic.

## Code And Architecture

Public-safe pattern: filter array and set result variable.

Pseudo-code or short sanitized snippet:

```text
items = getVar("items")
keyword = prompt()
result = items.filter(item => item.includes(keyword))
setVar("result", result)
```

What must not be copied:

- Full unauthorized source code: yes
- Real token/key/cookie: yes
- License algorithm: yes
- Admin URL: yes
- Abuse/bypass steps: yes

## Auto Wizard Architecture Mapping

- Variables/storage: array input and filtered output.
- Actions/expressions: JS action does loop/filter.
- OCR/image/color: not relevant.
- Node/control tree: not relevant.
- File/log/network: not relevant.
- UI/config: prompt keyword input.
- Backend/deployment: not relevant.
- Error recovery: handle non-array input.

## Wanlong Script Use

- Useful for Wanlong: yes
- Target state: filter resource names, task names, role lists
- Target action: choose matching item from known list
- Test screenshot needed: no
- Failure recovery: return empty list and log keyword
- Log fields: keyword, input_count, output_count

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
- Follow-up: Add exact-match variant to API cheatsheet.

