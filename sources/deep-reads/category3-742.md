# Deep Read: 742 Extract Numbers From Text

## Source

- Thread ID: 742
- Category: 3
- URL: https://bbs.zdjl.site/#/thread/detail/742
- Created at: 2021-07-23T13:11:57.000Z
- Read at: 2026-06-19 Asia/Taipei
- Reader: Codex browser-fetch
- Raw file: Browser/API fetch reviewed; raw JSON not published
- Posts file: Browser/API posts list reviewed; raw JSON not published

## Access Check

- Page/API opened successfully: yes
- Not a 504/blank/error page: yes
- Main post reviewed: yes
- Replies reviewed: yes, first page replies reviewed
- Images reviewed: yes, no media needed
- Video or attachment checked: yes, no public media copied

## Classification

- Primary topic: numeric parsing
- Secondary topics: OCR text cleanup, regex, parseFloat
- Contains code: yes
- Contains setup/deployment: no
- Contains backend/API: no
- Contains UI/config: no
- Contains OCR/image/color/coordinate: yes
- Contains flow/condition/listener: yes
- Contains environment/emulator issue: no
- Sensitive content: no

## Summary

Problem pattern: OCR or mixed strings often contain words, punctuation, and numbers, but conditions need a numeric value.

Recommended public explanation: Use a small parser to keep digits and decimal points, then convert to a number before comparing.

Important limits: Negative numbers, commas, units, and multiple numbers need explicit handling.

Common failure mode: `parseFloat` only reading the first usable number or returning NaN on empty text.

## Code And Architecture

Public-safe pattern: Sanitize and parse.

```text
text = ocr_result
numeric_text = keep_digits_and_decimal(text)
value = parse_float(numeric_text)
if is_valid(value):
  compare(value)
```

What must not be copied:

- Full unauthorized source code: yes
- Real token/key/cookie: yes
- License algorithm: yes
- Admin URL: yes
- Abuse/bypass steps: yes

## Auto Wizard Architecture Mapping

- Variables/storage: raw text, numeric text, parsed value.
- Actions/expressions: JS regex or parser helper.
- OCR/image/color: OCR output cleanup.
- Node/control tree: can also parse node text.
- File/log/network: log raw and parsed values for calibration.
- UI/config: choose parser mode if text contains several numbers.
- Backend/deployment: not relevant.
- Error recovery: handle NaN and empty OCR safely.

## Wanlong Script Use

- Useful for Wanlong: yes
- Target state: parse_resource_or_timer_text
- Target action: parse resource level, count, timer, coordinate labels
- Test screenshot needed: yes, OCR text samples
- Failure recovery: retry OCR or use default safe value
- Log fields: raw_text, numeric_text, parsed_value, parse_status

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
- Follow-up: Add parser helper to visual/OCR notes.
