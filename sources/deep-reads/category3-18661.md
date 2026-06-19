# Deep Read: 18661 Bezier And Spline Gesture Curves

## Source

- Thread ID: 18661
- Category: 3
- URL: https://bbs.zdjl.site/#/thread/detail/18661
- Created at: 2024-08-27T05:41:25.030Z
- Read at: 2026-06-19 Asia/Taipei
- Reader: Codex browser-fetch
- Raw file: Browser/API fetch reviewed; raw JSON not published
- Posts file: Browser/API posts list reviewed; raw JSON not published

## Access Check

- Page/API opened successfully: yes
- Not a 504/blank/error page: yes
- Main post reviewed: yes
- Replies reviewed: yes, first page replies reviewed
- Images reviewed: yes, formula/image references reviewed; media not republished
- Video or attachment checked: yes, example script reference not copied

## Classification

- Primary topic: gesture curve generation
- Secondary topics: Bezier curve, spline curve, control points, smooth swipe
- Contains code: yes
- Contains setup/deployment: no
- Contains backend/API: no
- Contains UI/config: no
- Contains OCR/image/color/coordinate: yes
- Contains flow/condition/listener: no
- Contains environment/emulator issue: no
- Sensitive content: no

## Summary

Problem pattern: Straight-line swipes can look mechanical or fail in UI contexts that expect curved gestures.

Recommended public explanation: Generate a list of points from control points, then feed that point list to a gesture action.

Important limits: Math formulas can be complex; public notes should focus on input/output contract unless full derivation is needed.

Common failure mode: Too few points produce jagged movement; too many points can slow execution.

## Code And Architecture

Public-safe pattern: Curve function returns gesture points.

```text
points = build_curve(control_points, steps)
gesture(points)
```

What must not be copied:

- Full unauthorized source code: yes
- Real token/key/cookie: yes
- License algorithm: yes
- Admin URL: yes
- Abuse/bypass steps: yes

## Auto Wizard Architecture Mapping

- Variables/storage: control points, step count, duration.
- Actions/expressions: generate point list before gesture.
- OCR/image/color: coordinates may come from recognition.
- Node/control tree: not relevant.
- File/log/network: log points only for debugging.
- UI/config: expose smoothness/duration.
- Backend/deployment: not relevant.
- Error recovery: fall back to straight swipe if curve generation fails.

## Wanlong Script Use

- Useful for Wanlong: yes
- Target state: natural_swipe_or_view_rotate
- Target action: rotate camera or scroll panels with smooth point lists
- Test screenshot needed: yes, before/after swipe states
- Failure recovery: reduce curve complexity and retry
- Log fields: control_points, steps, duration, gesture_result

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
- Follow-up: Cross-link with c3-01 high precision curve and gesture notes.
