# GitHub Actions 驗證流程

這份學習庫上傳到 GitHub 後，會用 `.github/workflows/verify-learning-library.yml` 自動檢查公開版本是否還能被驗收。

## 何時會執行

- push 到 `main`
- push 到 `master`
- pull request
- 手動執行 `workflow_dispatch`

## CI 會檢查什麼

```powershell
.\tools\verify-category3-coverage.ps1
.\tools\export-learning-status.ps1
.\tools\export-study-queue.ps1
.\tools\verify-deep-read-records.ps1
.\tools\verify-source-attribution.ps1
.\tools\verify-github-package.ps1
.\tools\verify-learning-library.ps1
```

這些檢查會確認：

- 分類 3 的 309 個 Thread ID 沒有漏號、重複或多餘。
- 機器可讀進度摘要可以重新產生，並保留目前未完成狀態。
- 完整深讀隊列可以重新產生，並保留 c3 批次；分類 4 已依使用者要求暫停。
- deep-read 紀錄欄位和狀態格式可被檢查。
- 來源歸因、來源 URL、深讀模板和公開整理規則可被檢查。
- GitHub 發布包必備文件、PR 模板與 Issue 模板存在。
- `.gitignore` 會排除 raw、tmp、log、截圖與影片輸出。
- 公開檔案沒有過大的附件或疑似 secret 格式。
- Markdown、JSON、PowerShell 語法和整體學習庫結構能通過本地驗證。

## 為什麼 CI 不檢查論壇

PowerShell 直連論壇目前可能失敗；先前分類 3 的已學批次曾用瀏覽器式請求讀取，但 2026-06-19 Codex 端續讀 c3-04 時出現 504/連線問題。GitHub CI 的目標是檢查「已整理到倉庫裡的內容是否安全、完整、可驗收」，不是證明外部論壇可連。

要檢查論壇恢復狀態，請在本機執行：

```powershell
.\tools\verify-learning-library.ps1 -CheckForum
```

如果這條失敗，只代表外部來源暫時不可讀；不能因此把待讀文章標為已完成。

## CI 紅燈時怎麼看

- `verify-category3-coverage.ps1` 失敗：檢查 `sources/category-3-full-manifest.md` 和 `sources/category-3-topic-coverage.md` 是否不同步。
- `verify-deep-read-records.ps1` 失敗：檢查某篇 deep-read note 是否缺欄位、狀態錯誤，或把未完成文章標成 `specialized`。
- `verify-github-package.ps1` 失敗：檢查必備文件、PR/Issue 模板、`.gitignore`、附件、疑似 secret。
- `verify-learning-library.ps1` 失敗：先看它輸出的 `failures` 欄位，再修對應文件或工具。
