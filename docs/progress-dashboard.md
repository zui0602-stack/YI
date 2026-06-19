# 自動精靈學習庫進度看板

更新日期：2026-06-18 Asia/Taipei

## 總狀態

目前狀態：第一版可開始學習，尚未宣稱最終完成。

原因：

- 分類 3 教程區已完整建立 309 篇清單，也已逐篇打開稽核。
- 其中 177 篇已轉成專題筆記，來源摘要層 0 篇，132 篇仍要補成專題。
- 分類 4 已依 2026-06-18 使用者最新指令停止後續學習，只保留歷史參考。

## 可以直接開始學的內容

| 主題 | 狀態 | 文件 |
|---|---|---|
| 學習入口 | 可用 | `START_HERE.md` |
| 學習路線 | 可用 | `docs/tutorial-learning-roadmap.md` |
| 架構理解 | 可用 | `docs/architecture.md` |
| JS/API 速查 | 可用 | `docs/zdjl-api-cheatsheet.md` |
| 動作與表達式 | 可用 | `docs/action-expression-dsl-notes.md` |
| 流程、UI、變量 | 可用 | `docs/flow-ui-variable-notes.md` |
| 條件、跳轉、監聽 | 可用 | `docs/condition-jump-listener-notes.md` |
| OCR、找圖、找色 | 可用 | `docs/visual-recognition-notes.md` |
| 文件、API、日誌 | 可用 | `docs/file-api-log-notes.md` |
| 環境、權限、模擬器 | 可用 | `docs/environment-stability-notes.md` |
| 節點、控件、普通 App | 可用 | `docs/node-app-automation-notes.md` |
| UI、Markdown、彈窗 | 可用 | `docs/ui-markdown-dialog-notes.md` |
| AI 輔助與審核 | 可用 | `docs/ai-assisted-script-notes.md` |
| 後端、架設、熱更新 | 可用安全版 | `docs/backend-deployment-notes.md` |
| 萬龍虛擬測試 | 可用 | `virtual_test_flow.md` |

## 還要補的內容

| 來源 | 待補 | 文件 |
|---|---:|---|
| 分類 3 來源摘要層 | 0 篇 | `source-00` 已補成正式深讀 |
| 分類 3 待專題化 | 132 篇 | `sources/category-3-topic-coverage.md` |
| 分類 4 | 暫停 | 使用者要求不再學 |

## 論壇目前狀態

2026-06-18 Node/Chrome 式請求已能讀取分類 3 API 與 source-00 到 c3-03 正文；PowerShell 直連仍可能失敗。

2026-06-19 續讀 c3-04 時 Codex 可用路徑出現 504/連線問題。若只用 PowerShell 探測，可能得到假失敗；但沒有讀到正文、回覆、附件/影片線索前，不能把新批次標成已學。

```powershell
.\tools\probe-zdjl-forum.ps1
```

後續補讀順序：

1. 從 `c3-04` 開始處理：132 篇待專題化文章。
2. 每篇建立 deep-read note，並整理成原創專題摘要。
3. 每批補完後更新 `sources/category-3-topic-coverage.md`。
4. 重新執行 `tools/verify-category3-coverage.ps1`。

## 最新檢查結果

已檢查分類 3 覆蓋表：

```text
manifest_count = 309
coverage_total = 309
coverage_unique = 309
missing_count = 0
extra_count = 0
duplicate_count = 0
```

這代表目前 309 個 Thread ID 在覆蓋追蹤表中沒有漏號、重複或多餘，但不代表 309 篇都已完成專題化。

2026-06-18 追加檢查：

- `tools/verify-learning-library.ps1`：本地驗證通過。
- `docs/current-status-report.md`：已新增人工檢查用短版戰情表，彙整分類 3/4 數字、GitHub readiness、論壇卡點與下一步施工順序。
- `tools/verify-deep-read-records.ps1`：逐篇深讀紀錄驗證通過；目前沒有正式 deep-read 紀錄，因此只回報警告，不視為失敗。
- `tools/verify-github-package.ps1`：GitHub 發布包驗證通過；目前只提醒 `tmp/` 有本地測試檔，仍由 `.gitignore` 排除。
- `.github/workflows/verify-learning-library.yml`：已新增 GitHub Actions 驗證流程，push/PR 後會跑本地驗證工具。
- `.github/PULL_REQUEST_TEMPLATE.md` 與 `.github/ISSUE_TEMPLATE/`：已新增 PR/Issue 模板，方便公開後追蹤深讀批次、來源歸因審核與論壇恢復同步。
- `sources/learning-status.generated.json`：已新增機器可讀進度摘要，目前標記 `completion.complete = false`，並列出未完成原因。
- `sources/study-queue.full.generated.md/json`：已新增完整深讀隊列，現在只記錄分類 3 的 132 篇待專題化；分類 4 已暫停。
- `docs/source-attribution-policy.md` 與 `tools/verify-source-attribution.ps1`：已新增來源歸因與公開整理規則，避免 GitHub 版變成論壇搬運。
- `tools/verify-learning-library.ps1 -CheckForum`：PowerShell 探測可能失敗；分類 3 實際續讀仍要以能讀到正文與回覆的路徑為準。
- `sources/study-queue.generated.md`：保留舊批次樣本；正式續讀以 `sources/study-queue.full.generated.md/json` 的 132 篇分類 3 隊列為準。

## 給學習者的最短路線

如果今天就要開始學，照這個順序：

1. `START_HERE.md`
2. `docs/tutorial-learning-roadmap.md`
3. `docs/architecture.md`
4. `docs/zdjl-api-cheatsheet.md`
5. `docs/flow-ui-variable-notes.md`
6. `docs/visual-recognition-notes.md`
7. `virtual_test_flow.md`

這條路線可以先支援你理解萬龍採集腳本、虛擬測試流程與後續修改方向。

## 後續同步工具

- `tools/probe-zdjl-forum.ps1`：先確認論壇是否能讀。
- `tools/sync-zdjl-forum.ps1`：保存分類索引、指定文章詳情與回覆原始 JSON。
- `tools/build-study-queue.ps1`：把 raw JSON 或現有覆蓋表轉成待深讀清單。
- `tools/export-learning-status.ps1`：把分類 3 覆蓋、deep-read 批次、GitHub readiness 與完成狀態輸出成 JSON；分類 4 只標記暫停。
- `tools/export-study-queue.ps1`：把 c3-04 到 c3-10 輸出成完整隊列；分類 4 已暫停。
- `tools/verify-deep-read-records.ps1`：檢查每篇 deep-read note 的必要欄位、狀態與安全寫回。
- `tools/verify-source-attribution.ps1`：檢查來源 URL、來源範圍、deep-read 模板與公開整理政策。
- `tools/verify-github-package.ps1`：檢查 GitHub 發布包的必備文件、PR/Issue 模板、忽略規則、檔案大小、二進位附件與疑似 secret 格式。
- `tools/verify-learning-library.ps1`：一鍵檢查本地學習庫是否可驗收。
- `docs/forum-sync-workflow.md`：同步、深讀、回填與 GitHub 安全檢查流程。
- `docs/deep-read-protocol.md`：逐篇文章深讀與批次驗收標準。
- `sources/deep-read-ledger.md`：目前批次帳本。
