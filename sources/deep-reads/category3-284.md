# Deep Read: 284 Auto Wizard Tutorial Part 1

## Source

- Thread ID: 284
- Category: 3
- URL: https://bbs.zdjl.site/#/thread/detail/284
- Created at: 2021-05-22T12:52:03.000Z
- Read at: 2026-06-18 Asia/Taipei
- Reader: Codex browser-fetch
- Raw file: Browser/API fetch reviewed; raw JSON not published
- Posts file: Browser/API posts list reviewed; raw JSON not published

## Access Check

- Page/API opened successfully: yes
- Not a 504/blank/error page: yes
- Main post reviewed: yes
- Replies reviewed: yes, first page replies reviewed
- Images reviewed: yes, screenshot references reviewed from post metadata; images not republished
- Video or attachment checked: not applicable

## Classification

- Primary topic: beginner action and condition model
- Secondary topics: click, swipe, image/text/color/node actions, run conditions, run count
- Contains code: yes
- Contains setup/deployment: no
- Contains backend/API: no
- Contains UI/config: yes
- Contains OCR/image/color/coordinate: yes
- Contains flow/condition/listener: yes
- Contains environment/emulator issue: no
- Sensitive content: no

## Summary

Problem pattern: Beginners need a map of action types and run conditions before building stable scripts.

Recommended public explanation: Auto Wizard scripts are built from action types plus conditions. Visual, text, color, and node checks should gate actions so the script does not click before the page is ready.

Important limits: Full-screen image and color detection can be brittle; narrow the area and add retry limits.

Common failure mode: Clicking while a page is still loading because no run condition confirms readiness.

## Code And Architecture

Public-safe pattern: Every action that depends on a screen state should have a readiness detector.

Pseudo-code or short sanitized snippet:

```text
if page_ready_by_color_or_node:
  click_target()
else:
  wait_and_retry()
```

What must not be copied:

- Full unauthorized source code: yes
- Real token/key/cookie: yes
- License algorithm: yes
- Admin URL: yes
- Abuse/bypass steps: yes

## Auto Wizard Architecture Mapping

- Variables/storage: count and state variables.
- Actions/expressions: click, swipe, open app, run JS, run multi-action.
- OCR/image/color: readiness and target detection.
- Node/control tree: preferred for normal app controls.
- File/log/network: not core in this thread.
- UI/config: run conditions and repeat counts.
- Backend/deployment: not relevant.
- Error recovery: retry conditions and action count limits.

## Wanlong Script Use

- Useful for Wanlong: yes
- Target state: core action vocabulary
- Target action: gate every map/search/gather click with a detector
- Test screenshot needed: yes, per screen condition
- Failure recovery: retry with count and fallback state
- Log fields: detector_type, action_type, retry_count, ready_state

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
- Follow-up: Use this as beginner glossary.
