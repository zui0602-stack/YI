# Deep Read: 20249 AI Agent For Auto Wizard JS

## Source

- Thread ID: 20249
- Category: 3
- URL: https://bbs.zdjl.site/#/thread/detail/20249
- Created at: 2025-01-21T10:25:26.361Z
- Read at: 2026-06-18 Asia/Taipei
- Reader: Codex browser-fetch
- Raw file: Browser/API fetch reviewed; raw JSON not published
- Posts file: Browser/API posts list reviewed; raw JSON not published

## Access Check

- Page/API opened successfully: yes
- Not a 504/blank/error page: yes
- Main post reviewed: yes
- Replies reviewed: yes, first page replies reviewed
- Images reviewed: yes, image references reviewed from post metadata; images not republished
- Video or attachment checked: not applicable

## Classification

- Primary topic: AI assisted scripting
- Secondary topics: Coze agent, model selection, ZdjlAPI TypeScript descriptions, prompt knowledge base
- Contains code: no
- Contains setup/deployment: yes
- Contains backend/API: yes
- Contains UI/config: yes
- Contains OCR/image/color/coordinate: no
- Contains flow/condition/listener: no
- Contains environment/emulator issue: no
- Sensitive content: possible, AI-generated code must be reviewed before use

## Summary

Problem pattern: Auto Wizard JS writing is easier when an AI assistant has a curated API description and domain-specific examples.

Recommended public explanation: Build AI help around a precise API knowledge base, ask it for small reviewed changes, and validate every generated function call against official or locally verified Auto Wizard behavior.

Important limits: AI output is not proof of correctness. It can hallucinate APIs, misuse async behavior, or ignore safety limits.

Common failure mode: Treating generated code as ready-to-run without checking permissions, variables, selectors, and runtime version.

## Code And Architecture

Public-safe pattern: AI acts as draft generator and reviewer, not final authority.

Pseudo-code or short sanitized snippet:

```text
prompt = api_reference + task_state + constraints
draft = ask_ai(prompt)
review(draft, api_reference, safety_rules)
test_on_small_case(draft)
```

What must not be copied:

- Full unauthorized source code: yes
- Real token/key/cookie: yes
- License algorithm: yes
- Admin URL: yes
- Abuse/bypass steps: yes

## Auto Wizard Architecture Mapping

- Variables/storage: include known variable names and scopes in prompts.
- Actions/expressions: ask AI to state which action type each snippet belongs to.
- OCR/image/color: require real screenshots before accepting visual logic.
- Node/control tree: require selector evidence before node code.
- File/log/network: review all network calls and logs.
- UI/config: use AI to draft user-facing configuration schemas.
- Backend/deployment: keep API keys and endpoints out of public prompts.
- Error recovery: ask AI for failure branches, then test them.

## Wanlong Script Use

- Useful for Wanlong: yes
- Target state: prompt and code-review helper for Wanlong collection script
- Target action: generate small draft functions and review state-machine transitions
- Test screenshot needed: yes, for any visual detector AI proposes
- Failure recovery: require AI output to include logging and fallback branches
- Log fields: prompt_version, generated_function, review_result, test_result

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
- Follow-up: Add AI review checklist to prompt files later.
