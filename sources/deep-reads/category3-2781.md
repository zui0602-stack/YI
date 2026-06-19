# Deep Read: 2781 Slider Offset Gesture

## Source

- Thread ID: 2781
- Category: 3
- URL: https://bbs.zdjl.site/#/thread/detail/2781
- Created at: 2022-01-18T23:40:11.919Z
- Read at: 2026-06-18 Asia/Taipei
- Reader: Codex browser-fetch
- Raw file: Browser/API fetch reviewed; raw JSON not published
- Posts file: Browser/API posts list reviewed; raw JSON not published

## Access Check

- Page/API opened successfully: yes, thread API and posts API opened with browser-style request
- Not a 504/blank/error page: yes
- Main post reviewed: yes
- Replies reviewed: yes, first page replies reviewed
- Images reviewed: yes, image/video references reviewed from post metadata; media not republished
- Video or attachment checked: yes, external Bilibili link detected; public note uses main-post architecture only

## Classification

- Primary topic: visual coordinate gesture
- Secondary topics: slider control, db coordinate offset, gesture calibration
- Contains code: yes
- Contains setup/deployment: no
- Contains backend/API: no
- Contains UI/config: no
- Contains OCR/image/color/coordinate: yes
- Contains flow/condition/listener: no
- Contains environment/emulator issue: no
- Sensitive content: yes, verification-like slider content must be limited to authorized UI testing

## Summary

Problem pattern: A slider target can be handled by measuring the x-axis difference between the current slider position and the target position, then applying that delta to the actual drag handle coordinate.

Recommended public explanation: For an owned UI control, detect `start` and `end` positions in the same coordinate unit, calculate `deltaX = endX - startX`, and swipe the handle from its base position by that offset.

Important limits: Do not publish a reusable bypass for third-party verification systems. Real screens need calibration, and the post itself notes that the final value must be tuned per situation.

Common failure mode: Mixing db, px, and hard-coded screen coordinates causes the drag to undershoot or overshoot.

## Code And Architecture

Public-safe pattern: Treat slider movement as coordinate normalization plus controlled swipe.

Pseudo-code or short sanitized snippet:

```text
delta_x = target_x_db - slider_x_db
gesture_drag(handle_x, handle_y, handle_x + delta_x, handle_y)
```

What must not be copied:

- Full unauthorized source code: yes
- Real token/key/cookie: yes
- License algorithm: yes
- Admin URL: yes
- Abuse/bypass steps: yes

## Auto Wizard Architecture Mapping

- Variables/storage: store detected start and target positions.
- Actions/expressions: calculate the delta before the gesture action.
- OCR/image/color: use image/color detection only on authorized screens.
- Node/control tree: not relevant for game/self-drawn sliders.
- File/log/network: log detected positions for calibration.
- UI/config: expose coordinate offsets as config.
- Backend/deployment: not relevant.
- Error recovery: retry only after re-detecting current positions.

## Wanlong Script Use

- Useful for Wanlong: limited
- Target state: owned UI slider or drag gesture calibration
- Target action: derive swipe endpoint from detected offset
- Test screenshot needed: yes, slider start and target states
- Failure recovery: log start_x, target_x, delta_x, result
- Log fields: slider_start_x, slider_target_x, delta_x, gesture_result

## Writeback

- Topic note updated: yes, docs/category-3-c3-01-deep-read.md
- Tutorial map updated: pending
- Category 3 coverage updated: yes
- Category 4 continuation updated: not applicable
- Study queue updated: yes
- Safety review done: yes

## Decision

- Status: specialized
- Exclusion reason:
- Follow-up: Keep this as coordinate/gesture calibration only; do not expand into bypass guidance.
