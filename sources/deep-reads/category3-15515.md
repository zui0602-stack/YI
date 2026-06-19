# Deep Read: 15515 Image Verification Script

## Source

- Thread ID: 15515
- Category: 3
- URL: https://bbs.zdjl.site/#/thread/detail/15515
- Created at: 2024-01-05T04:41:26.289Z
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
- Video or attachment checked: yes, example script reference not copied

## Classification

- Primary topic: image verification risk review
- Secondary topics: OCR filter, click text, calibration limits
- Contains code: yes
- Contains setup/deployment: no
- Contains backend/API: no
- Contains UI/config: no
- Contains OCR/image/color/coordinate: yes
- Contains flow/condition/listener: yes
- Contains environment/emulator issue: yes
- Sensitive content: yes, verification bypass content

## Summary

Problem pattern: The post describes using OCR/filtering to solve a verification challenge.

Recommended public explanation: Do not reproduce the bypass. Keep only the safety lesson: verification screens are sensitive, OCR calibration is device-dependent, and automation should not defeat third-party anti-abuse systems.

Important limits: No click sequence, no filter values, no runnable example, no target platform detail.

Common failure mode: Treating OCR success on one VM/device as generally reliable.

## Code And Architecture

Public-safe pattern: Verification-like content is excluded from operational guidance.

```text
if screen_is_verification_or_anti_abuse:
  stop_or_request_manual_authorized_action()
  log_safe_reason()
```

What must not be copied:

- Full unauthorized source code: yes
- Real token/key/cookie: yes
- License algorithm: yes
- Admin URL: yes
- Abuse/bypass steps: yes

## Auto Wizard Architecture Mapping

- Variables/storage: verification_detected flag.
- Actions/expressions: safety gate before interacting with verification UI.
- OCR/image/color: only detect and stop; no bypass guidance.
- Node/control tree: not relevant.
- File/log/network: log that manual action is required.
- UI/config: explain manual verification requirement.
- Backend/deployment: not relevant.
- Error recovery: stop safely and notify user.

## Wanlong Script Use

- Useful for Wanlong: limited
- Target state: safety_gate_verification_screen
- Target action: stop automation if verification-like screen appears
- Test screenshot needed: yes, only for detection/stop behavior
- Failure recovery: request manual action
- Log fields: verification_detected, action_taken, screenshot_saved

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
- Follow-up: Keep as safety exclusion example.
