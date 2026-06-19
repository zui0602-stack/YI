# Deep Read: 470 Detect App In Foreground

## Source

- Thread ID: 470
- Category: 3
- URL: https://bbs.zdjl.site/#/thread/detail/470
- Created at: 2021-06-21T08:01:38.000Z
- Read at: 2026-06-19 Asia/Taipei
- Reader: Codex browser-fetch
- Raw file: Browser/API fetch reviewed; raw JSON not published
- Posts file: Browser/API posts list reviewed; raw JSON not published

## Access Check

- Page/API opened successfully: yes
- Not a 504/blank/error page: yes
- Main post reviewed: yes
- Replies reviewed: yes, first page replies reviewed
- Images reviewed: yes, no media needed
- Video or attachment checked: yes, no public media copied

## Classification

- Primary topic: foreground app condition
- Secondary topics: package name, node condition, watchdog
- Contains code: no
- Contains setup/deployment: no
- Contains backend/API: no
- Contains UI/config: no
- Contains OCR/image/color/coordinate: no
- Contains flow/condition/listener: yes
- Contains environment/emulator issue: yes
- Sensitive content: no

## Summary

Problem pattern: A long-running script must know whether the target app is still active.

Recommended public explanation: Use an appearance/node condition with the target package name to confirm the foreground app.

Important limits: Package name must be collected from the actual device and app; it may differ across variants.

Common failure mode: Continuing game actions after the app has been backgrounded or a system page is on top.

## Code And Architecture

Public-safe pattern: Add a watchdog before risky actions.

```text
if foreground_package != target_package:
  recover_to_target_app()
else:
  continue_flow()
```

What must not be copied:

- Full unauthorized source code: yes
- Real token/key/cookie: yes
- License algorithm: yes
- Admin URL: yes
- Abuse/bypass steps: yes

## Auto Wizard Architecture Mapping

- Variables/storage: target package name.
- Actions/expressions: foreground condition before action groups.
- OCR/image/color: optional fallback if package detection is unavailable.
- Node/control tree: use package/node condition.
- File/log/network: log foreground mismatch.
- UI/config: expose package name field.
- Backend/deployment: not relevant.
- Error recovery: relaunch app or stop safely.

## Wanlong Script Use

- Useful for Wanlong: yes
- Target state: app_watchdog
- Target action: confirm game remains foreground before clicks
- Test screenshot needed: no
- Failure recovery: relaunch or ask user if app missing
- Log fields: expected_package, current_package, recovery_action

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
- Follow-up: Include in environment stability watchdog notes.
