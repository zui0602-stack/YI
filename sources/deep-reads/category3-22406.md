# Deep Read: 22406 OCR Raw Object Handling

## Source

- Thread ID: 22406
- Category: 3
- URL: https://bbs.zdjl.site/#/thread/detail/22406
- Created at: 2025-08-23T13:06:19.455Z
- Read at: 2026-06-19 Asia/Taipei
- Reader: Codex browser-fetch
- Raw file: Browser/API fetch reviewed; raw JSON not published
- Posts file: Browser/API posts list reviewed; raw JSON not published

## Access Check

- Page/API opened successfully: yes
- Not a 504/blank/error page: yes
- Main post reviewed: yes
- Replies reviewed: yes, no replies on first page
- Images reviewed: yes, no media republished
- Video or attachment checked: yes, no public media copied

## Classification

- Primary topic: OCR result object
- Secondary topics: text field, left coordinate, line splitting, blank handling
- Contains code: yes
- Contains setup/deployment: no
- Contains backend/API: no
- Contains UI/config: no
- Contains OCR/image/color/coordinate: yes
- Contains flow/condition/listener: yes
- Contains environment/emulator issue: no
- Sensitive content: no

## Summary

Problem pattern: OCR can return structured objects, not just a flat string; using the raw object helps recover coordinates and line text.

Recommended public explanation: Inspect the recognition array, access each object's text and coordinate fields, and merge lines deliberately when needed.

Important limits: OCR ordering can depend on region and screen text density.

Common failure mode: Assuming all needed text is in one array item.

## Code And Architecture

Public-safe pattern: Iterate OCR objects and normalize them.

```text
items = ocr_raw(region)
for item in items:
  read item.text and item.left
merge_or_filter(items)
```

What must not be copied:

- Full unauthorized source code: yes
- Real token/key/cookie: yes
- License algorithm: yes
- Admin URL: yes
- Abuse/bypass steps: yes

## Auto Wizard Architecture Mapping

- Variables/storage: OCR raw array, merged text, chosen item.
- Actions/expressions: access object fields by index/key.
- OCR/image/color: raw OCR object processing.
- Node/control tree: similar pattern applies to node arrays.
- File/log/network: log normalized OCR objects for fixture building.
- UI/config: set recognition region for better ordering.
- Backend/deployment: not relevant.
- Error recovery: handle missing index and empty arrays.

## Wanlong Script Use

- Useful for Wanlong: yes
- Target state: structured_ocr_parser
- Target action: parse multi-line prompt/resource panel
- Test screenshot needed: yes, multi-line OCR cases
- Failure recovery: widen/narrow region and re-run OCR
- Log fields: item_count, selected_index, selected_text, merge_result

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
- Follow-up: Add examples to OCR fixture schema.
