# GitHub 上傳指南

這份指南只處理「學習庫怎麼安全放到 GitHub」。它不代表論壇內容已全部深讀完成；完整完成度仍以 `docs/completion-audit.md` 為準。

## 目前可公開的定位

建議倉庫說明寫成：

```text
Auto Wizard learning library and tutorial study notes.
This repository contains public-safe summaries, architecture notes, checklists, and verification tools.
Source coverage is still in progress while the forum is intermittently unavailable.
```

中文說法：

```text
自動精靈教程學習庫：整理公開安全的教程摘要、架構筆記、檢查清單與驗證工具。
目前分類 3 的全量深讀仍在進行中，未宣稱全部教程已完成；分類 4 已依使用者要求暫停。
```

## 上傳前必跑檢查

在工作區執行：

```powershell
.\tools\verify-category3-coverage.ps1
.\tools\export-learned-traceability.ps1
.\tools\export-learning-status.ps1
.\tools\export-study-queue.ps1
.\tools\verify-deep-read-records.ps1
.\tools\verify-source-attribution.ps1
.\tools\verify-github-package.ps1
.\tools\verify-learning-library.ps1
```

判斷方式：

- `verify-category3-coverage.ps1`：`missing_count`、`extra_count`、`duplicate_count` 都要是 `0`。
- `export-learned-traceability.ps1`：重新產生 `sources/learned-thread-traceability.json`，確認已學 Thread ID 都能追到專題文件。
- `export-learning-status.ps1`：重新產生 `sources/learning-status.generated.json`。
- `export-study-queue.ps1`：重新產生 `sources/study-queue.full.generated.md/json`。
- `verify-deep-read-records.ps1`：已有正式紀錄時必須通過欄位、狀態與安全寫回檢查。
- `verify-source-attribution.ps1`：檢查來源 URL、深讀模板、範圍口徑與公開整理規則。
- `verify-github-package.ps1`：不能有 failure；若警告 raw/tmp 存在，確認它們仍在 `.gitignore` 內。
- `verify-learning-library.ps1`：`ok = true`。

論壇外部狀態另跑：

```powershell
.\tools\verify-learning-library.ps1 -CheckForum
```

如果論壇不可用，這條會失敗；這只代表不能繼續深讀來源，不代表本地文件壞掉。

## 應該放進 GitHub 的內容

- `.gitignore`
- `CONTRIBUTING.md`
- `README.md`
- `SECURITY.md`
- `START_HERE.md`
- `virtual_test_flow.md`
- `.github/workflows/verify-learning-library.yml`
- `.github/PULL_REQUEST_TEMPLATE.md`
- `.github/ISSUE_TEMPLATE/`
- `docs/`
- `sources/`
- `prompts/`
- `examples/`
- `templates/`
- `tests/fixtures/`
- `tools/`

## 不應該放進 GitHub 的內容

- `sources/raw/`
- `sources/raw-*`
- `tmp/`
- `logs/`
- `reports/`
- `screenshots/`
- 大量影片、壓縮檔、APK、EXE
- 任何未審查的論壇原文 dump、附件、截圖、影片

`.gitignore` 已經擋住這些路徑；發布前仍要跑 `tools/verify-github-package.ps1` 再確認一次。

## GitHub 倉庫描述建議

Repository name:

```text
auto-wizard-learning-library
```

Description:

```text
Public-safe Auto Wizard tutorial notes, architecture maps, script testing prompts, and verification tools.
```

Topics:

```text
auto-wizard
automation
ocr
script-testing
learning-notes
```

License:

```text
No license yet, unless original ownership and redistribution rights are confirmed.
```

原因：這份學習庫目前是整理筆記與安全摘要，來源論壇內容、附件、影片、商業腳本不應被當成可自由再授權的內容。

## 首頁閱讀順序

GitHub README 可引導讀者照這個順序看：

1. `START_HERE.md`
2. `docs/progress-dashboard.md`
3. `docs/tutorial-learning-roadmap.md`
4. `docs/learned-tutorial-classification.md`
5. `docs/architecture.md`
6. `docs/zdjl-api-cheatsheet.md`
7. `virtual_test_flow.md`
8. `docs/completion-audit.md`

## 發布後繼續深讀

後續照這個流程補分類 3：

1. `tools/probe-zdjl-forum.ps1`
2. `tools/sync-zdjl-forum.ps1`
3. `tools/build-study-queue.ps1`
4. `tools/new-deep-read-note.ps1`
5. 更新對應 `docs/*.md` 專題筆記
6. 更新 `sources/category-3-topic-coverage.md`
7. 重新產生 `sources/learned-thread-traceability.json`
8. 重新跑所有驗證工具

分類 3 的完成目標是：`sources/category-3-topic-coverage.md` 裡「尚未專題化」歸零。

分類 4 已依 2026-06-18 使用者最新指令停止後續學習，不再列入完成目標。
