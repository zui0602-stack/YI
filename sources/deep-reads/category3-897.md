# Deep Read: 897 Graphic Verification OCR

## Source

- Thread ID: 897
- Category: 3
- URL: https://bbs.zdjl.site/#/thread/detail/897
- Created at: 2021-08-07T14:42:54.000Z
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

- Primary topic: graphic verification safety boundary
- Secondary topics: OCR, input result, verification screen
- Contains code: yes
- Contains setup/deployment: no
- Contains backend/API: no
- Contains UI/config: no
- Contains OCR/image/color/coordinate: yes
- Contains flow/condition/listener: yes
- Contains environment/emulator issue: no
- Sensitive content: yes, captcha/verification automation

## Summary

Problem pattern: The post discusses reading and inputting graphic verification text.

Recommended public explanation: Do not include a tutorial for solving verification challenges. Record only that verification screens should trigger manual review or a safe stop in public automation.

Important limits: No solver workflow, no OCR range, no input automation for third-party verification.

Common failure mode: Treating a platform security challenge as an ordinary OCR field.

## Code And Architecture

Public-safe pattern: Detect and stop on verification.

```text
if verification_screen_detected:
  save_debug_screenshot()
  notify_manual_action_required()
  stop()
```

What must not be copied:

- Full unauthorized source code: yes
- Real token/key/cookie: yes
- License algorithm: yes
- Admin URL: yes
- Abuse/bypass steps: yes

## Auto Wizard Architecture Mapping

- Variables/storage: verification flag.
- Actions/expressions: safety condition.
- OCR/image/color: only detection for stopping.
- Node/control tree: not relevant.
- File/log/network: save safe diagnostic screenshot.
- UI/config: show manual action prompt.
- Backend/deployment: not relevant.
- Error recovery: resume only after user confirms authorized completion.

## Wanlong Script Use

- Useful for Wanlong: limited
- Target state: verification_stop_gate
- Target action: stop and ask user if verification appears
- Test screenshot needed: yes, detection only
- Failure recovery: manual review
- Log fields: verification_detected, screenshot_path, stopped

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
- Follow-up: Keep as public safety rule, not implementation guide.
