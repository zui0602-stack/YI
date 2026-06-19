# Deep Read: 9408 Color Filter Optimization Tool

## Source

- Thread ID: 9408
- Category: 3
- URL: https://bbs.zdjl.site/#/thread/detail/9408
- Created at: 2022-12-23T13:12:14.328Z
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
- Video or attachment checked: yes, tool/example reference not copied

## Classification

- Primary topic: image recognition filter tuning
- Secondary topics: color replacement, similarity search, multi-scene stability
- Contains code: yes
- Contains setup/deployment: no
- Contains backend/API: no
- Contains UI/config: yes
- Contains OCR/image/color/coordinate: yes
- Contains flow/condition/listener: no
- Contains environment/emulator issue: no
- Sensitive content: no

## Summary

Problem pattern: A target can look different across backgrounds, so a single color threshold may be unstable.

Recommended public explanation: Test candidate filter/similarity settings across multiple screenshots and choose the settings that repeatedly find the target without false positives.

Important limits: This is a calibration process; publish the method, not copyrighted target images or full downloaded tool code.

Common failure mode: Tuning on one screenshot and failing in other scenes.

## Code And Architecture

Public-safe pattern: Multi-fixture filter search.

```text
for config in candidate_filter_configs:
  results = test_config_on_all_screenshots(config)
  score = stability_score(results)
choose_best_safe_config(score)
```

What must not be copied:

- Full unauthorized source code: yes
- Real token/key/cookie: yes
- License algorithm: yes
- Admin URL: yes
- Abuse/bypass steps: yes

## Auto Wizard Architecture Mapping

- Variables/storage: screenshot list, filter config, similarity values.
- Actions/expressions: run recognition with variable config.
- OCR/image/color: color replacement and image search.
- Node/control tree: not relevant for game images.
- File/log/network: store test result table, not original protected assets.
- UI/config: calibration panel.
- Backend/deployment: not relevant.
- Error recovery: detect false positives and retune.

## Wanlong Script Use

- Useful for Wanlong: yes
- Target state: visual_filter_calibration
- Target action: tune resource/health/progress icon recognition across scenes
- Test screenshot needed: yes, multiple backgrounds
- Failure recovery: lower confidence or add secondary check
- Log fields: config_id, screenshot_id, found_count, false_positive_count, score

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
- Follow-up: Add calibration table pattern to visual recognition notes.
