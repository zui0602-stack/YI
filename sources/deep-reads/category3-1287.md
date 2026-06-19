# Deep Read: 1287 Complex Game Gathering Script

## Source

- Thread ID: 1287
- Category: 3
- URL: https://bbs.zdjl.site/#/thread/detail/1287
- Created at: 2021-09-12T10:12:03.521Z
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

- Primary topic: game gathering state machine
- Secondary topics: settings UI, visual recognition, script splitting, resource search
- Contains code: no
- Contains setup/deployment: no
- Contains backend/API: no
- Contains UI/config: yes
- Contains OCR/image/color/coordinate: yes
- Contains flow/condition/listener: yes
- Contains environment/emulator issue: yes
- Sensitive content: no

## Summary

Problem pattern: A complex game script becomes maintainable only after it is split into settings, initialization, search, and action phases.

Recommended public explanation: Use a config UI for options, an initialization phase for inventory/food/position, a recognition phase to find resources, and an action phase to gather or recover.

Important limits: The post is game-specific; reusable value is the architecture, not the exact coordinates or screenshots.

Common failure mode: Putting every action in one long list makes resource-specific branches hard to debug.

## Code And Architecture

Public-safe pattern: Use subflows and explicit state transitions.

```text
settings -> init -> find_resource -> gather -> verify_result -> init
```

What must not be copied:

- Full unauthorized source code: yes
- Real token/key/cookie: yes
- License algorithm: yes
- Admin URL: yes
- Abuse/bypass steps: yes

## Auto Wizard Architecture Mapping

- Variables/storage: resource type, food count, search mode, current state.
- Actions/expressions: run subscript or jump to state-specific actions.
- OCR/image/color: recognize resource icons, resource labels, status text.
- Node/control tree: rarely useful in self-drawn game UI.
- File/log/network: record resource found, gather start/end, failure reason.
- UI/config: expose resource options and recovery switches.
- Backend/deployment: not relevant.
- Error recovery: return to init if search or gather state fails.

## Wanlong Script Use

- Useful for Wanlong: yes
- Target state: city, field, search_resource, gather_resource, recover
- Target action: split mining/gathering flow into independently testable states
- Test screenshot needed: yes, city, field, search, resource panel, gathering
- Failure recovery: if resource not found, change search direction or return city
- Log fields: state, resource_type, recognition_result, gather_result, retry_count

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
- Follow-up: Merge concepts into Wanlong virtual test state flow.
