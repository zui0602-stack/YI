# Deep Read: 10015 High Precision Curve Gesture

## Source

- Thread ID: 10015
- Category: 3
- URL: https://bbs.zdjl.site/#/thread/detail/10015
- Created at: 2023-01-29T01:24:17.612Z
- Read at: 2026-06-18 Asia/Taipei
- Reader: Codex browser-fetch
- Raw file: Browser/API fetch reviewed; raw JSON not published
- Posts file: Browser/API posts list reviewed; raw JSON not published

## Access Check

- Page/API opened successfully: yes
- Not a 504/blank/error page: yes
- Main post reviewed: yes
- Replies reviewed: yes, first page replies reviewed
- Images reviewed: yes, diagram references reviewed from post metadata; images not republished
- Video or attachment checked: yes, shared script links detected; packages not republished

## Classification

- Primary topic: curve gesture math
- Secondary topics: circle, ellipse, radians, trigonometry, rotation, multi-point gesture
- Contains code: yes
- Contains setup/deployment: no
- Contains backend/API: no
- Contains UI/config: yes
- Contains OCR/image/color/coordinate: yes
- Contains flow/condition/listener: no
- Contains environment/emulator issue: no
- Sensitive content: possible, do not copy full shared script

## Summary

Problem pattern: Natural or complex gestures need generated point lists instead of straight-line swipes.

Recommended public explanation: Generate points from circle/ellipse formulas, convert degrees to radians, add the center offset, and feed the point sequence into a gesture action with controlled timing.

Important limits: More points are smoother but heavier. Coordinate scaling and rotation must be tested on the real device resolution.

Common failure mode: Passing degrees into JS trig functions that expect radians.

## Code And Architecture

Public-safe pattern: Use math formulas to generate sanitized point arrays.

Pseudo-code or short sanitized snippet:

```text
radian = degree * PI / 180
x = center_x + cos(radian) * radius_x
y = center_y + sin(radian) * radius_y
append_point(x, y)
```

What must not be copied:

- Full unauthorized source code: yes
- Real token/key/cookie: yes
- License algorithm: yes
- Admin URL: yes
- Abuse/bypass steps: yes

## Auto Wizard Architecture Mapping

- Variables/storage: radius, center, angle range, point count.
- Actions/expressions: JS math expression creates gesture points.
- OCR/image/color: anchor point may come from detector.
- Node/control tree: not relevant.
- File/log/network: log generated point count and bounds.
- UI/config: expose curve parameters.
- Backend/deployment: not relevant.
- Error recovery: clamp points inside screen bounds.

## Wanlong Script Use

- Useful for Wanlong: yes
- Target state: smooth map movement or gesture stress tests
- Target action: generate curved gesture paths
- Test screenshot needed: yes, target path/anchor
- Failure recovery: reduce radius or point count if gesture fails
- Log fields: center_x, center_y, radius_x, radius_y, point_count

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
- Follow-up: Pair with gesture transform topic.
