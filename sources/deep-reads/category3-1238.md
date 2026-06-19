# Deep Read: 1238 Markdown Rich Text

## Source

- Thread ID: 1238
- Category: 3
- URL: https://bbs.zdjl.site/#/thread/detail/1238
- Created at: 2021-09-06T09:40:16.472Z
- Read at: 2026-06-19 Asia/Taipei
- Reader: Codex browser-fetch
- Raw file: Browser/API fetch reviewed; raw JSON not published
- Posts file: Browser/API posts list reviewed; raw JSON not published

## Access Check

- Page/API opened successfully: yes
- Not a 504/blank/error page: yes
- Main post reviewed: yes
- Replies reviewed: yes, first page replies reviewed
- Images reviewed: yes, external image-host concept reviewed; media not republished
- Video or attachment checked: yes, no public media copied

## Classification

- Primary topic: Markdown UI
- Secondary topics: system prompt, font styling, links, images
- Contains code: yes
- Contains setup/deployment: no
- Contains backend/API: no
- Contains UI/config: yes
- Contains OCR/image/color/coordinate: no
- Contains flow/condition/listener: no
- Contains environment/emulator issue: no
- Sensitive content: no

## Summary

Problem pattern: Auto Wizard prompts can be made clearer with Markdown formatting.

Recommended public explanation: Use the Markdown prefix, then apply headings, font styling, links, images, and separators for readable status panels.

Important limits: External image hosts may disappear; public repos should not depend on private image links.

Common failure mode: Forgetting the Markdown prefix, so formatting displays as plain text.

## Code And Architecture

Public-safe pattern: Build status text separately, then render it in a Markdown-capable prompt.

```text
message = build_markdown_status(state, counters, warnings)
show_markdown_prompt(message)
```

What must not be copied:

- Full unauthorized source code: yes
- Real token/key/cookie: yes
- License algorithm: yes
- Admin URL: yes
- Abuse/bypass steps: yes

## Auto Wizard Architecture Mapping

- Variables/storage: status text, theme, image path.
- Actions/expressions: compose Markdown prompt.
- OCR/image/color: not relevant.
- Node/control tree: not relevant.
- File/log/network: local images should be safe assets, not raw forum media.
- UI/config: status panel, help page, config explanation.
- Backend/deployment: not relevant.
- Error recovery: fallback to plain text if Markdown fails.

## Wanlong Script Use

- Useful for Wanlong: yes
- Target state: status_panel
- Target action: show current mode, target resource, countdown, errors
- Test screenshot needed: yes, rendered panel
- Failure recovery: plain text summary
- Log fields: panel_state, markdown_rendered

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
- Follow-up: Add to UI/Markdown dialog notes.
