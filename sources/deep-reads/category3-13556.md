# Deep Read: 13556 Cross-Device Coordinate Adaptation

## Source

- Thread ID: 13556
- Category: 3
- URL: https://bbs.zdjl.site/#/thread/detail/13556
- Created at: 2023-08-19T03:08:40.810Z
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

- Primary topic: coordinate scaling
- Secondary topics: device info, percentage coordinates, resolution adaptation
- Contains code: yes
- Contains setup/deployment: no
- Contains backend/API: no
- Contains UI/config: yes
- Contains OCR/image/color/coordinate: yes
- Contains flow/condition/listener: no
- Contains environment/emulator issue: yes
- Sensitive content: no

## Summary

Problem pattern: Hard-coded coordinates from one device drift on another resolution.

Recommended public explanation: Store coordinates as percentages or convert from a base resolution using current device width and height.

Important limits: Aspect ratio and game UI scaling can still change element positions; detection should be preferred when possible.

Common failure mode: Mixing dp, px, percent, and base-resolution values without naming the unit.

## Code And Architecture

Public-safe pattern: Normalize coordinates through a conversion helper.

```text
current = get_device_size()
point = convert_percent_or_base_coord(raw_coord, base_size, current)
click(point.x, point.y)
```

What must not be copied:

- Full unauthorized source code: yes
- Real token/key/cookie: yes
- License algorithm: yes
- Admin URL: yes
- Abuse/bypass steps: yes

## Auto Wizard Architecture Mapping

- Variables/storage: base width, base height, raw coordinate string.
- Actions/expressions: coordinate conversion before click/swipe.
- OCR/image/color: use recognition to validate converted point.
- Node/control tree: prefer node selectors in normal apps.
- File/log/network: log base/current size and converted point.
- UI/config: let user set base device.
- Backend/deployment: not relevant.
- Error recovery: if click fails, capture screenshot and recalibrate.

## Wanlong Script Use

- Useful for Wanlong: yes
- Target state: coordinate_adapter
- Target action: convert saved points across RedFinger and local devices
- Test screenshot needed: yes, multiple resolutions
- Failure recovery: fall back to image/color detection
- Log fields: base_w, base_h, current_w, current_h, raw_coord, converted_coord

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
- Follow-up: Add to Wanlong coordinate normalization guidelines.
