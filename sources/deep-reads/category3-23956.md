# Deep Read: 23956 Script Editor Introduction

## Source

- Thread ID: 23956
- Category: 3
- URL: https://bbs.zdjl.site/#/thread/detail/23956
- Created at: 2026-01-17T07:29:57.890Z
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

- Primary topic: script editor basics
- Secondary topics: repeat count, global listener, run wait, repeat interval, editor UI
- Contains code: no
- Contains setup/deployment: no
- Contains backend/API: no
- Contains UI/config: yes
- Contains OCR/image/color/coordinate: no
- Contains flow/condition/listener: yes
- Contains environment/emulator issue: no
- Sensitive content: no

## Summary

Problem pattern: New users often miss top-level script settings that control looping, global listeners, and action timing.

Recommended public explanation: Before writing complex logic, understand the script settings and action editor: repeat count controls loop behavior, global listeners handle cross-cutting events, and run waits/repeat intervals control pacing.

Important limits: Timing values are context-dependent. Short waits are faster but can race UI loading.

Common failure mode: Setting repeat count or wait time incorrectly, causing scripts to run once, loop forever, or click before the screen is ready.

## Code And Architecture

Public-safe pattern: Treat editor settings as the first layer of the runtime configuration.

Pseudo-code or short sanitized snippet:

```text
script_config = {
  repeat_count: 0,
  action_wait_ms: tuned_delay,
  global_listeners: enabled_events
}
```

What must not be copied:

- Full unauthorized source code: yes
- Real token/key/cookie: yes
- License algorithm: yes
- Admin URL: yes
- Abuse/bypass steps: yes

## Auto Wizard Architecture Mapping

- Variables/storage: settings decide whether state persists across loops.
- Actions/expressions: action waits and repeat intervals affect every action.
- OCR/image/color: wait settings should match detector speed.
- Node/control tree: wait settings should match UI load.
- File/log/network: log loop count and action timing.
- UI/config: core editor settings.
- Backend/deployment: not relevant.
- Error recovery: global listener can catch popups or stop states.

## Wanlong Script Use

- Useful for Wanlong: yes
- Target state: base script runtime settings
- Target action: configure repeat, waits, global listeners, and pacing
- Test screenshot needed: no
- Failure recovery: tune waits and add listener for unexpected states
- Log fields: repeat_count, wait_ms, listener_hit, action_index

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
- Follow-up: Add editor-settings checklist to Wanlong setup docs.
