# Deep Read: 15069 Remote Script Control

## Source

- Thread ID: 15069
- Category: 3
- URL: https://bbs.zdjl.site/#/thread/detail/15069
- Created at: 2023-12-01T05:36:34.645Z
- Read at: 2026-06-18 Asia/Taipei
- Reader: Codex browser-fetch
- Raw file: Browser/API fetch reviewed; raw JSON not published
- Posts file: Browser/API posts list reviewed; raw JSON not published

## Access Check

- Page/API opened successfully: yes
- Not a 504/blank/error page: yes
- Main post reviewed: yes
- Replies reviewed: yes, first page replies reviewed
- Images reviewed: not applicable
- Video or attachment checked: not applicable

## Classification

- Primary topic: backend control API
- Secondary topics: public server, Ubuntu, Node.js, script state, remote start/stop
- Contains code: yes
- Contains setup/deployment: yes
- Contains backend/API: yes
- Contains UI/config: no
- Contains OCR/image/color/coordinate: no
- Contains flow/condition/listener: yes
- Contains environment/emulator issue: no
- Sensitive content: yes, remote control and token/API patterns require strict authorization

## Summary

Problem pattern: A script can poll or call a server to know whether it should continue running, pause, or stop.

Recommended public explanation: Build a small authenticated API that stores device/script state, then let each authorized script report heartbeat and read its allowed command. Keep credentials private and audit every remote command.

Important limits: Do not publish real endpoints, admin routes, tokens, or a turnkey control panel for unauthorized devices.

Common failure mode: Running remote control without authentication or heartbeat timeout, causing stale or hijacked states.

## Code And Architecture

Public-safe pattern: Separate heartbeat, command read, and command write APIs.

Pseudo-code or short sanitized snippet:

```text
heartbeat(device_id, state)
command = read_command(device_id, auth_token)
if command in allowed_commands:
  apply_command(command)
```

What must not be copied:

- Full unauthorized source code: yes
- Real token/key/cookie: yes
- License algorithm: yes
- Admin URL: yes
- Abuse/bypass steps: yes

## Auto Wizard Architecture Mapping

- Variables/storage: device ID, role name, current task state, last command.
- Actions/expressions: poll API before long-running loops.
- OCR/image/color: not relevant.
- Node/control tree: not relevant.
- File/log/network: network request, heartbeat log, command log.
- UI/config: server URL and token must be private config.
- Backend/deployment: Node.js service, authentication, rate limits, logs.
- Error recovery: if API fails, use local safe default and retry later.

## Wanlong Script Use

- Useful for Wanlong: yes
- Target state: multi-device farm control on owned accounts/devices
- Target action: pause/resume/stop collection worker based on server command
- Test screenshot needed: no, API mock needed
- Failure recovery: local continue/stop policy when server is unavailable
- Log fields: device_id, state, command, last_seen_at, api_status

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
- Follow-up: Connect with existing backend security review prompts.
