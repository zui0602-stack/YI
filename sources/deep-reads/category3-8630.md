# Deep Read: 8630 Slider Image Positioning

## Source

- Thread ID: 8630
- Category: 3
- URL: https://bbs.zdjl.site/#/thread/detail/8630
- Created at: 2022-11-14T07:18:41.817Z
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

- Primary topic: image-based slider calibration
- Secondary topics: gesture endpoint, image matching, smooth swipe
- Contains code: no
- Contains setup/deployment: no
- Contains backend/API: no
- Contains UI/config: no
- Contains OCR/image/color/coordinate: yes
- Contains flow/condition/listener: yes
- Contains environment/emulator issue: no
- Sensitive content: yes, verification-like slider content must be limited to authorized UI testing

## Summary

Problem pattern: A slider movement can be calibrated by detecting a stable start image and a target image, then swiping between derived points.

Recommended public explanation: Only for owned or authorized UI tests, use image matching to determine a start and target point and perform a smooth gesture.

Important limits: Do not publish reusable third-party verification bypass logic or tuning details.

Common failure mode: Capturing target images with too much variable background, causing incorrect endpoint detection.

## Code And Architecture

Public-safe pattern: Authorized gesture calibration.

```text
start = find_authorized_start_marker()
target = find_authorized_target_marker()
if both_found:
  smooth_swipe(start, target)
```

What must not be copied:

- Full unauthorized source code: yes
- Real token/key/cookie: yes
- License algorithm: yes
- Admin URL: yes
- Abuse/bypass steps: yes

## Auto Wizard Architecture Mapping

- Variables/storage: start marker, target marker, offsets.
- Actions/expressions: image-find result into gesture endpoint.
- OCR/image/color: image matching and filtering.
- Node/control tree: not relevant for self-drawn screens.
- File/log/network: log calibration results only for owned UI.
- UI/config: expose offsets for authorized tests.
- Backend/deployment: not relevant.
- Error recovery: re-detect instead of replaying stale coordinates.

## Wanlong Script Use

- Useful for Wanlong: limited
- Target state: authorized_gesture_test
- Target action: learn marker-based swipe calibration
- Test screenshot needed: yes, owned UI only
- Failure recovery: log markers and stop if target missing
- Log fields: start_found, target_found, start_xy, target_xy

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
- Follow-up: Keep as calibration note only; do not expand into bypass guidance.
