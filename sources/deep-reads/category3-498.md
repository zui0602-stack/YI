# Deep Read: 498 Coordinate Variable Basics

## Source

- Thread ID: 498
- Category: 3
- URL: https://bbs.zdjl.site/#/thread/detail/498
- Created at: 2021-06-25T08:50:20.000Z
- Read at: 2026-06-19 Asia/Taipei
- Reader: Codex browser-fetch
- Raw file: Browser/API fetch reviewed; raw JSON not published
- Posts file: Browser/API posts list reviewed; raw JSON not published

## Access Check

- Page/API opened successfully: yes
- Not a 504/blank/error page: yes
- Main post reviewed: yes, main post is brief and points to early replies
- Replies reviewed: yes, first page replies reviewed for tutorial steps
- Images reviewed: yes, image references reviewed from replies; media not republished
- Video or attachment checked: yes, no public media copied

## Classification

- Primary topic: coordinate variable beginner guide
- Secondary topics: permission setup, editing UI, click coordinate
- Contains code: no
- Contains setup/deployment: yes
- Contains backend/API: no
- Contains UI/config: yes
- Contains OCR/image/color/coordinate: yes
- Contains flow/condition/listener: no
- Contains environment/emulator issue: yes
- Sensitive content: no

## Summary

Problem pattern: New users need to understand how coordinate variables are captured and reused.

Recommended public explanation: Treat coordinate variables as reusable references that should be named, tested, and calibrated rather than scattered as anonymous hard-coded values.

Important limits: Coordinates are fragile across resolutions; prefer OCR/image/node recognition when possible.

Common failure mode: Copying a coordinate from one device and expecting it to work everywhere.

## Code And Architecture

Public-safe pattern: Capture once, name clearly, validate before use.

```text
target_point = configured_coordinate
if screen_matches_expected_state:
  click(target_point)
```

What must not be copied:

- Full unauthorized source code: yes
- Real token/key/cookie: yes
- License algorithm: yes
- Admin URL: yes
- Abuse/bypass steps: yes

## Auto Wizard Architecture Mapping

- Variables/storage: named coordinate variable.
- Actions/expressions: click/gesture uses variable.
- OCR/image/color: can validate target before click.
- Node/control tree: prefer selectors for normal app UI.
- File/log/network: log coordinate and screen size.
- UI/config: expose calibration screen.
- Backend/deployment: not relevant.
- Error recovery: recalibrate on screen-size mismatch.

## Wanlong Script Use

- Useful for Wanlong: yes
- Target state: coordinate_calibration
- Target action: manage fixed points for known buttons only after visual check
- Test screenshot needed: yes, each calibrated button
- Failure recovery: use image/OCR fallback
- Log fields: coord_name, coord_value, screen_size, validation_result

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
- Follow-up: Cross-link with coordinate adaptation notes.
