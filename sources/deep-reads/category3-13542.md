# Deep Read: 13542 Points And Personal Center

## Source

- Thread ID: 13542
- Category: 3
- URL: https://bbs.zdjl.site/#/thread/detail/13542
- Created at: 2023-08-18T14:06:21.079Z
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

- Primary topic: platform UI basics
- Secondary topics: personal center, points, daily sign-in, beginner navigation
- Contains code: no
- Contains setup/deployment: no
- Contains backend/API: no
- Contains UI/config: yes
- Contains OCR/image/color/coordinate: no
- Contains flow/condition/listener: no
- Contains environment/emulator issue: no
- Sensitive content: no

## Summary

Problem pattern: New users need to know where account points and point-earning actions live before downloading or testing scripts.

Recommended public explanation: The path is platform UI navigation, not script logic: open Auto Wizard, enter the user/profile area, then check the points page and daily tasks.

Important limits: This does not teach automation APIs; it is onboarding for the script marketplace/user account.

Common failure mode: Confusing platform points with script runtime variables or app data.

## Code And Architecture

Public-safe pattern: Record this as onboarding UI knowledge only.

Pseudo-code or short sanitized snippet:

```text
open_app()
tap_profile()
open_points_center()
review_daily_tasks()
```

What must not be copied:

- Full unauthorized source code: yes
- Real token/key/cookie: yes
- License algorithm: yes
- Admin URL: yes
- Abuse/bypass steps: yes

## Auto Wizard Architecture Mapping

- Variables/storage: not relevant.
- Actions/expressions: not relevant.
- OCR/image/color: not relevant.
- Node/control tree: possible UI-navigation reference only.
- File/log/network: not relevant.
- UI/config: account and marketplace onboarding.
- Backend/deployment: not relevant.
- Error recovery: not relevant.

## Wanlong Script Use

- Useful for Wanlong: no
- Target state: user onboarding
- Target action: none
- Test screenshot needed: no
- Failure recovery: not applicable
- Log fields: not applicable

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
- Follow-up: Keep under platform basics, not Wanlong runtime docs.
