# 自動精靈學習庫入口

這裡是第一個要看的文件。這份學習庫目前已經整理成可放 GitHub 的第一版，但還不是最終完成版：分類 3 已完整建立 309 篇教程清單，source-00 已補成正式深讀；分類 4 已依 2026-06-18 最新指令停止後續學習，只保留歷史參考。

## 目前可以開始學的內容

| 區塊 | 狀態 | 入口 |
|---|---|---|
| 核心總教程 | 已整理 | `AUTO_WIZARD_CORE_TUTORIAL.md` |
| 總索引 | 已整理 | `docs/learning-library-index.md` |
| 學習路線 | 已整理 | `docs/tutorial-learning-roadmap.md` |
| GitHub 發布檢查 | 已整理 | `docs/github-publishing-checklist.md` |
| GitHub 上傳指南 | 已整理 | `docs/github-upload-guide.md` |
| GitHub Actions 驗證 | 已整理 | `docs/github-actions-ci.md` |
| GitHub PR/Issue 模板 | 已整理 | `.github/PULL_REQUEST_TEMPLATE.md`, `.github/ISSUE_TEMPLATE/` |
| 完成度稽核 | 已整理 | `docs/completion-audit.md` |
| 目前進度總覽 | 已整理 | `docs/current-status-report.md` |
| 論壇同步流程 | 已整理 | `docs/forum-sync-workflow.md` |
| 深讀規範 | 已整理 | `docs/deep-read-protocol.md` |
| 來源歸因政策 | 已整理 | `docs/source-attribution-policy.md` |
| 深讀隊列 | 已產生 | `sources/study-queue.generated.md` |
| 完整深讀隊列 | 已產生 | `sources/study-queue.full.generated.md` |
| 機器可讀進度 | 已產生 | `sources/learning-status.generated.json` |
| 已學分類 JSON | 已產生 | `sources/learned-tutorial-classification.json` |
| 已學 Thread 追查 | 已產生 | `sources/learned-thread-traceability.json` |
| 自動精靈架構 | 已整理 | `docs/architecture.md` |
| JS/API 速查 | 已整理 | `docs/zdjl-api-cheatsheet.md` |
| 視覺識別 | 已整理 | `docs/visual-recognition-notes.md` |
| 流程、條件、監聽 | 已整理 | `docs/flow-ui-variable-notes.md`、`docs/condition-jump-listener-notes.md` |
| UI、配置、彈窗 | 已整理 | `docs/ui-markdown-dialog-notes.md` |
| 文件、日誌、網路 | 已整理 | `docs/file-api-log-notes.md` |
| 環境、權限、模擬器 | 已整理 | `docs/environment-stability-notes.md` |
| 節點與普通 App | 已整理 | `docs/node-app-automation-notes.md` |
| 後端、熱更新、卡密 | 已整理安全版 | `docs/backend-deployment-notes.md` |
| 萬龍虛擬測試 | 已整理 | `virtual_test_flow.md`、`tests/fixtures/README.md` |

## 建議學習順序

1. 先讀 `AUTO_WIZARD_CORE_TUTORIAL.md`，它是目前最像教程本體的總講義，直接整理架構、JS、API、UI、條件、OCR、日誌、後端與萬龍狀態機。
2. 再讀 `docs/architecture.md`，理解自動精靈不是單一腳本，而是「狀態機、動作、變量、識別、日誌、恢復」組成的系統。
3. 再讀 `docs/zdjl-api-cheatsheet.md`，先把常用 API 的用途、失敗模式、判空習慣記起來。
4. 接著讀 `docs/flow-ui-variable-notes.md` 和 `docs/condition-jump-listener-notes.md`，理解循環、跳轉、監聽、失敗重試。
5. 然後讀 `docs/visual-recognition-notes.md`，把 OCR、找圖、找色、坐標自適應用在遊戲畫面。
6. 再讀 `docs/ui-markdown-dialog-notes.md`，學配置頁、狀態面板、彈窗預設分支。
7. 最後讀 `docs/backend-deployment-notes.md`、`docs/github-publishing-checklist.md`、`docs/github-upload-guide.md` 和 `docs/github-actions-ci.md`，準備發布、熱更新、授權、安全脫敏與自動驗證。
8. 要改萬龍腳本時，回到 `virtual_test_flow.md`，用截圖先做虛擬流程驗證，再改真腳本。

## 學習時要輸出的東西

每學完一個主題，至少留下這三樣：

- 一句話：這個主題解決什麼問題。
- 一張流程：正常流程、失敗流程、恢復流程。
- 一個最小練習：只驗證單一能力，不把所有東西一次混在一起。

## 目前還沒完全完成的地方

| 項目 | 狀態 | 下一步 |
|---|---|---|
| 分類 3 教程區 | 309 篇已建清單，177 篇已進專題，來源摘要層 0，132 篇待專題化 | 用瀏覽器式請求照 `sources/category-3-continuation-plan.md` 分批補 |
| 分類 4 交流區 | 已依使用者最新指令停止後續學習 | 只保留歷史參考，不再列入完成條件 |
| 影片與附件 | 已建立線索表 | 需要二次確認能否觀看、能否公開整理 |
| 敏感內容 | 已採安全摘要規則 | 不收真實密鑰、卡密算法、後台地址、可濫用繞過流程 |

## 開始改腳本前先做

1. 先把你的截圖放進 `tests/fixtures/` 對應規格，或用現有截圖做標註。
2. 先寫狀態表：目前在哪個畫面、要找什麼文字或按鈕、找不到時怎麼退回。
3. 先用 `prompts/wanlong-state-machine.md` 產生流程草稿。
4. 用 `prompts/code-review.md` 檢查有沒有漏判空、漏等待、漏錯誤截圖。
5. 才把流程放進真腳本。

## 檢查目前整理是否完整

在工作區可以執行：

```powershell
.\tools\verify-learning-library.ps1
```

分類 3 覆蓋表可單獨執行：

```powershell
.\tools\verify-category3-coverage.ps1
```

正常情況要看到：

```text
missing_count = 0
extra_count = 0
duplicate_count = 0
```

GitHub 發布包可單獨執行：

```powershell
.\tools\verify-github-package.ps1
```

要重新產生機器可讀進度摘要：

```powershell
.\tools\export-learning-status.ps1
```

要重新產生完整深讀隊列：

```powershell
.\tools\export-study-queue.ps1
```

要檢查來源歸因與公開整理規則：

```powershell
.\tools\verify-source-attribution.ps1
```

若要確認論壇是否恢復，再執行：

```powershell
.\tools\verify-learning-library.ps1 -CheckForum
```

分類 3 可用瀏覽器式請求續讀；不要因 PowerShell 探測失敗就停止。

後續先看 `docs/forum-sync-workflow.md`，用瀏覽器式請求小批量讀分類 3，再產生待深讀清單。

每篇文章正式補讀時，使用 `templates/deep-read-note.md` 記錄逐篇證據；每個批次完成時，使用 `templates/batch-review-report.md` 做批次驗收。

要建立單篇 deep-read 檔案時，可執行：

```powershell
.\tools\new-deep-read-note.ps1 -CategoryId 3 -ThreadId 2781 -Title "optional title"
```

## 2026-06-19 已學內容先看這裡

- 已經學好的內容不用再補日期。
- 先看 `docs/learned-tutorial-classification.md`，它把目前已學的教程按用途整理好。
- 如果要給工具或 AI 讀，使用 `sources/learned-tutorial-classification.json`。
- 如果要檢查 Thread ID 對應到哪些專題文件，使用 `sources/learned-thread-traceability.json`。
- 日期只留給尚未學的文章，用來判斷是否要跳過某個時間範圍。
