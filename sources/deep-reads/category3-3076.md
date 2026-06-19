# Deep Read: 3076 Dynamic Region Variables

## Source

- Thread ID: 3076
- Category: 3
- URL: https://bbs.zdjl.site/#/thread/detail/3076
- Created at: 2022-02-10T04:32:31.239Z
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

- Primary topic: dynamic recognition region
- Secondary topics: anchor text, percentage rectangle, region variables
- Contains code: no
- Contains setup/deployment: no
- Contains backend/API: no
- Contains UI/config: yes
- Contains OCR/image/color/coordinate: yes
- Contains flow/condition/listener: yes
- Contains environment/emulator issue: no
- Sensitive content: no

## Summary

Problem pattern: OCR or image search regions should move with UI elements instead of staying hard-coded.

Recommended public explanation: Find a stable anchor, read its percentage position, then build a rectangle by offsetting left/top/right/bottom values.

Important limits: Anchor recognition must be reliable; otherwise the derived region is wrong.

Common failure mode: Forgetting the percent sign or building the region string in the wrong order.

## Code And Architecture

Public-safe pattern: Anchor-based region construction.

```text
anchor = find_text("known label")
region = make_region(anchor.x_percent, anchor.y_percent, offsets)
run_ocr_or_image_search(region)
```

What must not be copied:

- Full unauthorized source code: yes
- Real token/key/cookie: yes
- License algorithm: yes
- Admin URL: yes
- Abuse/bypass steps: yes

## Auto Wizard Architecture Mapping

- Variables/storage: anchor position, offsets, computed region.
- Actions/expressions: string-format region with percent units.
- OCR/image/color: run recognition inside computed region.
- Node/control tree: optional if anchor is a UI node.
- File/log/network: save anchor and region for debugging.
- UI/config: expose offsets for calibration.
- Backend/deployment: not relevant.
- Error recovery: if anchor missing, do not use stale region.

## Wanlong Script Use

- Useful for Wanlong: yes
- Target state: dynamic_ocr_region
- Target action: read resource panel or prompt near a known label/icon
- Test screenshot needed: yes, anchor visible and shifted states
- Failure recovery: retry anchor detection or return to known screen
- Log fields: anchor_text, anchor_xy, region, ocr_result

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
- Follow-up: Use in virtual screenshot fixture annotation.
