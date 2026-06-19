# Deep Read: 21271 End Script Notification

## Source

- Thread ID: 21271
- Category: 3
- URL: https://bbs.zdjl.site/#/thread/detail/21271
- Created at: 2025-04-28T01:40:05.739Z
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

- Primary topic: notification webhook
- Secondary topics: script end reminder, HTTP GET, message encoding, newline formatting
- Contains code: yes
- Contains setup/deployment: yes
- Contains backend/API: yes
- Contains UI/config: yes
- Contains OCR/image/color/coordinate: no
- Contains flow/condition/listener: yes
- Contains environment/emulator issue: no
- Sensitive content: yes, reminder IDs/codes are secrets

## Summary

Problem pattern: Long-running scripts need an external notification when they finish or hit a significant state.

Recommended public explanation: Use a configured notification endpoint with a private reminder code, encode the message text, and call it at script end or error branches.

Important limits: Do not publish real reminder codes. Avoid sending sensitive game/account data in notification text.

Common failure mode: Not encoding the message, or hard-coding a secret in a public script.

## Code And Architecture

Public-safe pattern: Store the notification code in private config and encode text.

Pseudo-code or short sanitized snippet:

```text
notify_id = read_private_config("notify_id")
message = encode("script finished")
request(notification_url + notify_id + message)
```

What must not be copied:

- Full unauthorized source code: yes
- Real token/key/cookie: yes
- License algorithm: yes
- Admin URL: yes
- Abuse/bypass steps: yes

## Auto Wizard Architecture Mapping

- Variables/storage: private notification code and message text.
- Actions/expressions: JS request action on finish/error.
- OCR/image/color: not relevant.
- Node/control tree: not relevant.
- File/log/network: HTTP request and response logging.
- UI/config: notification enable switch.
- Backend/deployment: external reminder service.
- Error recovery: if notification fails, write local log.

## Wanlong Script Use

- Useful for Wanlong: yes
- Target state: gather task finished, no resource, fatal error
- Target action: send concise notification
- Test screenshot needed: no
- Failure recovery: local log if API fails
- Log fields: notify_event, request_status, message_type

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
- Follow-up: Add notification config to backend/security examples.
