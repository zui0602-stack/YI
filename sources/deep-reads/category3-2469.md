# Deep Read: 2469 Screenshot Without Floating Overlay

## Source

- Thread ID: 2469
- Category: 3
- URL: https://bbs.zdjl.site/#/thread/detail/2469
- Created at: 2021-12-26T10:29:22.545Z
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
- Video or attachment checked: yes, shared script link detected; package not republished

## Classification

- Primary topic: screen capture data
- Secondary topics: hide floating overlay, image data variable, base64, variable reference
- Contains code: no
- Contains setup/deployment: no
- Contains backend/API: no
- Contains UI/config: yes
- Contains OCR/image/color/coordinate: yes
- Contains flow/condition/listener: no
- Contains environment/emulator issue: yes
- Sensitive content: possible, avoid framing as paid-feature bypass

## Summary

Problem pattern: Floating overlays can contaminate screenshots used for recognition or debugging.

Recommended public explanation: Use the app's screenshot/recognition variable flow and hide-overlay setting where available, then reference the generated image data variable correctly when saving or uploading.

Important limits: Do not present this as a payment bypass. Use documented settings and only capture screens you are authorized to process.

Common failure mode: Writing the literal variable name plus `.base64` instead of reading the variable value, resulting in empty or invalid saved images.

## Code And Architecture

Public-safe pattern: Separate capture, variable reference, and file write.

Pseudo-code or short sanitized snippet:

```text
image_data = screen_capture_variable()
base64_data = image_data.base64
save_debug_image(base64_data)
```

What must not be copied:

- Full unauthorized source code: yes
- Real token/key/cookie: yes
- License algorithm: yes
- Admin URL: yes
- Abuse/bypass steps: yes

## Auto Wizard Architecture Mapping

- Variables/storage: image data variable and base64 property.
- Actions/expressions: set variable from screen recognition.
- OCR/image/color: clean screenshot before OCR/image matching.
- Node/control tree: not relevant.
- File/log/network: save screenshot for debug logs.
- UI/config: hide-overlay setting and capture area.
- Backend/deployment: not relevant.
- Error recovery: if image empty, verify variable-reference mode.

## Wanlong Script Use

- Useful for Wanlong: yes
- Target state: screenshot evidence and OCR debug
- Target action: capture clean screen before detector checks
- Test screenshot needed: yes, with and without overlay
- Failure recovery: log empty image data and variable mode
- Log fields: capture_mode, image_size, base64_present, overlay_hidden

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
- Follow-up: Add to visual debug evidence checklist.
