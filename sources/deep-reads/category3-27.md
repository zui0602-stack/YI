# Deep Read: 27 變量化座標與涂鴉腳本

## Source

- Thread ID: 27
- Category: 3
- URL: https://bbs.zdjl.site/#/thread/detail/27
- Created at: 2021-04-15T06:57:37.000Z
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
- Video or attachment checked: not applicable

## Classification

- Primary topic: coordinate expressions
- Secondary topics: variables, gesture recording, dynamic position, scaling
- Contains code: yes
- Contains setup/deployment: no
- Contains backend/API: no
- Contains UI/config: yes
- Contains OCR/image/color/coordinate: yes
- Contains flow/condition/listener: no
- Contains environment/emulator issue: no
- Sensitive content: no

## Summary

Problem pattern: Recorded gestures and fixed clicks are tied to one position or resolution.

Recommended public explanation: Convert fixed points into expressions based on a center coordinate, offset, scale, and optional fine-tuning variables.

Important limits: Formulas must be tested per coordinate unit; percent, dp, and pixel-like expression values are not interchangeable without conversion.

Common failure mode: Applying scale to only one axis or mixing coordinate units.

## Code And Architecture

Public-safe pattern: center plus offset plus scale.

Pseudo-code or short sanitized snippet:

```text
x = center.x + scale * offset.x + adjust.x
y = center.y + scale * offset.y + adjust.y
```

What must not be copied:

- Full unauthorized source code: yes
- Real token/key/cookie: yes
- License algorithm: yes
- Admin URL: yes
- Abuse/bypass steps: yes

## Auto Wizard Architecture Mapping

- Variables/storage: center, scale, x/y adjustment.
- Actions/expressions: click, swipe, single-finger gesture use JS coordinate expression.
- OCR/image/color: coordinate conversion supports visual actions.
- Node/control tree: not relevant.
- File/log/network: not relevant.
- UI/config: floating config can edit center and scale.
- Backend/deployment: not relevant.
- Error recovery: log computed coordinate before action.

## Wanlong Script Use

- Useful for Wanlong: yes
- Target state: coordinate adaptation across emulator resolution
- Target action: resource search button, gather button, return/home button offsets
- Test screenshot needed: yes
- Failure recovery: fallback to OCR/ROI if computed point misses
- Log fields: center_x, center_y, offset_x, offset_y, scale

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
- Follow-up: Add to Wanlong coordinate fixture docs.

