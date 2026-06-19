# Deep Read: 12789 密碼資料與雜湊邊界

## Source

- Thread ID: 12789
- Category: 3
- URL: https://bbs.zdjl.site/#/thread/detail/12789
- Created at: 2023-07-10T12:58:36.475Z
- Read at: 2026-06-18 Asia/Taipei
- Reader: Codex browser-fetch
- Raw file: Browser/API fetch reviewed; raw JSON not published
- Posts file: Browser/API posts list reviewed; raw JSON not published

## Access Check

- Page/API opened successfully: yes
- Not a 504/blank/error page: yes
- Main post reviewed: yes
- Replies reviewed: yes
- Images reviewed: yes, image references seen but not redistributed
- Video or attachment checked: not applicable

## Classification

- Primary topic: password handling and hash concept
- Secondary topics: script protection, Web Crypto limitation, weak hash warning
- Contains code: yes
- Contains setup/deployment: no
- Contains backend/API: no
- Contains UI/config: yes
- Contains OCR/image/color/coordinate: no
- Contains flow/condition/listener: yes
- Contains environment/emulator issue: yes
- Sensitive content: yes, license/password protection

## Summary

Problem pattern: Users put passwords or invitation codes in script conditions as plaintext.

Recommended public explanation: Avoid storing secrets in public scripts; a simple character-sum hash is only a teaching toy, not real security.

Important limits: Do not present weak client-side checks as licensing protection.

Common failure mode: Removing the condition or reading the script still bypasses weak client-only logic.

## Code And Architecture

Public-safe pattern: Explain hash concept and require server-side validation for real protection.

Pseudo-code or short sanitized snippet:

```text
entered = prompt_secret()
if verify_with_server_or_secure_store(entered):
    continue
```

What must not be copied:

- Full unauthorized source code: yes
- Real token/key/cookie: yes
- License algorithm: yes
- Admin URL: yes
- Abuse/bypass steps: yes

## Auto Wizard Architecture Mapping

- Variables/storage: never store real secret as plaintext.
- Actions/expressions: condition checks are not protection by themselves.
- OCR/image/color: not relevant.
- Node/control tree: not relevant.
- File/log/network: real verification should leave only minimal logs.
- UI/config: prompt fields should not reveal secret.
- Backend/deployment: server-side validation for real authorization.
- Error recovery: fail closed when verification is unavailable.

## Wanlong Script Use

- Useful for Wanlong: limited
- Target state: protect config values and avoid leaking credentials
- Target action: do not embed account secrets in script
- Test screenshot needed: no
- Failure recovery: stop script if authorization check fails
- Log fields: auth_result, reason_code, no_secret_value

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
- Follow-up: Keep in backend security review as weak-client-check warning.

