# Deep Read: 138 等待目標界面

## Source

- Thread ID: 138
- Category: 3
- URL: https://bbs.zdjl.site/#/thread/detail/138
- Created at: 2021-05-04T15:29:15.000Z
- Read at: 2026-06-18 Asia/Taipei
- Reader: Codex browser-fetch
- Raw file: Browser/API fetch reviewed; raw JSON not published
- Posts file: Browser/API posts list reviewed; raw JSON not published

## Access Check

- Page/API opened successfully: yes
- Not a 504/blank/error page: yes
- Main post reviewed: yes
- Replies reviewed: yes
- Images reviewed: yes, image-only main post reviewed by references
- Video or attachment checked: not applicable

## Classification

- Primary topic: wait until target screen
- Secondary topics: image detection, listener choice, performance
- Contains code: no
- Contains setup/deployment: no
- Contains backend/API: no
- Contains UI/config: no
- Contains OCR/image/color/coordinate: yes
- Contains flow/condition/listener: yes
- Contains environment/emulator issue: yes
- Sensitive content: no

## Summary

Problem pattern: A script needs to wait for the next screen before continuing.

Recommended public explanation: Use the lightest reliable detector: status flag, node/text/OCR, small ROI image, then full-screen image only as fallback.

Important limits: Large image scan can be slow or freeze-like; listener may be the wrong action type for simple waits.

Common failure mode: Repeated full-screen image search with no timeout.

## Code And Architecture

Public-safe pattern: bounded wait with small detector.

Pseudo-code or short sanitized snippet:

```text
until timeout:
    if target_text_or_small_image_exists():
        continue_next_step()
        break
```

What must not be copied:

- Full unauthorized source code: yes
- Real token/key/cookie: yes
- License algorithm: yes
- Admin URL: yes
- Abuse/bypass steps: yes

## Auto Wizard Architecture Mapping

- Variables/storage: wait timeout and retry count.
- Actions/expressions: wait loop or condition branch.
- OCR/image/color: prefer small ROI and clear target.
- Node/control tree: use node/text when available.
- File/log/network: log timeout screenshot.
- UI/config: expose timeout setting.
- Backend/deployment: not relevant.
- Error recovery: fallback path after timeout.

## Wanlong Script Use

- Useful for Wanlong: yes
- Target state: wait for gather/search/march screen
- Target action: continue only after button or text appears
- Test screenshot needed: yes
- Failure recovery: back/home and retry search
- Log fields: detector_type, roi, timeout_ms, retries

## Writeback

- Topic note updated: yes, docs/category-3-source-00-deep-read.md
- Tutorial map updated: pending
- Category 3 coverage updated: yes
- Category 4 continuation updated: not applicable
- Study queue updated: yes
- Safety review done: yes

## Decision

- Status: specialized
- Exclusion reason:
- Follow-up: Add to virtual test wait-state checklist.

