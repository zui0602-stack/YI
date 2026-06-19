# Deep Read: 18712 Grid Splitting And Screenshot Search

## Source

- Thread ID: 18712
- Category: 3
- URL: https://bbs.zdjl.site/#/thread/detail/18712
- Created at: 2024-08-31T17:57:06.761Z
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
- Video or attachment checked: yes, downloadable script reference not copied

## Classification

- Primary topic: grid visual recognition
- Secondary topics: region splitting, dynamic screenshots, image matching, matrix mapping
- Contains code: yes
- Contains setup/deployment: no
- Contains backend/API: no
- Contains UI/config: yes
- Contains OCR/image/color/coordinate: yes
- Contains flow/condition/listener: yes
- Contains environment/emulator issue: no
- Sensitive content: no

## Summary

Problem pattern: A game board can be processed by splitting one large rectangle into cells and mapping recognized images back into a matrix.

Recommended public explanation: Define the board region, divide it by rows and columns, take cell screenshots or search regions, then store matched types in a two-dimensional matrix.

Important limits: Public notes should not include full game-solving logic if it becomes a ready-made commercial script; focus on grid architecture.

Common failure mode: Off-by-one row/column mapping when using percentage coordinates.

## Code And Architecture

Public-safe pattern: Region to matrix pipeline.

```text
cells = split_region(board_region, rows, columns)
for cell in cells:
  type = recognize(cell)
  matrix[row][col] = type
```

What must not be copied:

- Full unauthorized source code: yes
- Real token/key/cookie: yes
- License algorithm: yes
- Admin URL: yes
- Abuse/bypass steps: yes

## Auto Wizard Architecture Mapping

- Variables/storage: board region, rows, columns, matrix.
- Actions/expressions: compute cell rectangles and indices.
- OCR/image/color: screenshot and find image per cell.
- Node/control tree: not relevant for game board.
- File/log/network: save matrix snapshot for debugging.
- UI/config: expose board region and grid size.
- Backend/deployment: not relevant.
- Error recovery: recapture board if recognition count is inconsistent.

## Wanlong Script Use

- Useful for Wanlong: yes
- Target state: visual_grid_or_map_parser
- Target action: split map/resource area into search cells
- Test screenshot needed: yes, board/area with cell boundaries
- Failure recovery: re-detect region and rebuild matrix
- Log fields: region, rows, columns, recognized_count, matrix_hash

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
- Follow-up: Add grid-region idea to visual recognition notes.
