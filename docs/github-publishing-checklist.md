# GitHub 發布與覆蓋稽核清單

本文件用來檢查「自動精靈學習庫」是否適合放到 GitHub，以及目前離完整目標還差哪些深讀工作。

目標：整理自動精靈論壇分類 3 中所有教學、教程、代碼與架設內容，形成原創、可維護、可公開的學習庫。分類 4 已依 2026-06-18 使用者最新指令停止後續學習，只保留歷史參考。

## 來源覆蓋

| 要求 | 目前證據 | 狀態 |
|---|---|---|
| 分類 3 教程區全部納入 | `sources/category-3-full-manifest.md` 記錄 309 個 Thread ID | 已完成索引 |
| 分類 3 詳情頁逐篇打開 | `sources/category-3-opened-audit.md` 記錄 309 / 309，錯誤 0 | 已完成稽核 |
| 分類 3 主題初篩 | `sources/category-3-api-scan.md` | 已完成 |
| 分類 3 反向主題覆蓋 | `sources/category-3-topic-coverage.md` 記錄 177 篇已進專題、來源摘要層 0、132 篇待專題化 | 追蹤中 |
| 已學內容分類總表 | `docs/learned-tutorial-classification.md` 與 `sources/learned-tutorial-classification.json` | 已建立 |
| 已學 Thread ID 追查 | `sources/learned-thread-traceability.json` 追查 177 個唯一已學 Thread ID 到 19 份專題文件 | 已建立 |
| 分類 3 續讀批次 | `sources/category-3-continuation-plan.md` 記錄論壇 504/逾時斷點、source-00、c3-01、c3-02、c3-03 與 c3-04 到 c3-10 批次 | 已建立 |
| 分類 4 | 使用者要求停止 | 不再列入完成條件 |

## 已整理專題

| 專題 | 文件 | 狀態 |
|---|---|---|
| GitHub 總入口 | `docs/learning-library-index.md` | 已整理 |
| 架構理解 | `docs/architecture.md` | 已整理 |
| JS/API 基礎 | `docs/js-api-notes.md` | 已整理 |
| API 速查 | `docs/zdjl-api-cheatsheet.md` | 已整理 |
| 核心教程 | `docs/core-tutorial-notes.md` | 已整理 |
| 流程、UI、變量 | `docs/flow-ui-variable-notes.md` | 已整理 |
| 條件、跳轉、監聽 | `docs/condition-jump-listener-notes.md` | 已整理 |
| 文件、API、日誌 | `docs/file-api-log-notes.md` | 已整理 |
| 視覺識別 | `docs/visual-recognition-notes.md` | 已整理 |
| 後端、架設、卡密、熱更新 | `docs/backend-deployment-notes.md` | 已整理 |
| 環境、權限、模擬器 | `docs/environment-stability-notes.md` | 已整理 |
| 節點與普通 App | `docs/node-app-automation-notes.md` | 已整理 |
| AI 輔助與代碼審核 | `docs/ai-assisted-script-notes.md` | 已整理 |
| 動作、表達式與 DSL | `docs/action-expression-dsl-notes.md` | 已整理 |
| UI、Markdown、彈窗與配置界面 | `docs/ui-markdown-dialog-notes.md` | 已整理 |
| 影片線索 | `docs/video-tutorial-notes.md` | 已整理第一版 |
| 教學地圖 | `docs/tutorial-map.md` | 已整理 |
| 已學分類總表 | `docs/learned-tutorial-classification.md` | 已整理 |
| 已學追查索引 | `sources/learned-thread-traceability.json` | 已建立 |
| Prompt 與範例配置 | `prompts/`, `examples/`, `tests/fixtures/` | 已建立第一版 |
| 後端安全模板 | `prompts/backend-security-review.md`, `examples/update-manifest.example.json`, `examples/backend-api-contract.example.json` | 已建立第一版 |

## GitHub 可公開原則

可以公開：

- 來源連結。
- 原創摘要。
- 架構圖、流程圖、狀態機。
- API 使用模式與坑點。
- 脫敏模板。
- 假資料配置。
- 萬龍虛擬測試流程與測試表。

不能公開：

- 論壇完整原文搬運。
- 未授權完整源碼。
- 真實 API key、token、cookie。
- 卡密算法、管理地址、後台密鑰。
- 可繞過平台安全、驗證碼、風控、廣告對抗的完整操作手冊。
- 付費附件或商業腳本內容。

## 版權整理規則

- 每份筆記保留來源 ID 與連結。
- 以「問題模式 -> 原理 -> 建議做法 -> 限制」重新整理。
- 代碼只保留短片段、偽代碼或脫敏模板。
- 外部附件只記錄存在與用途，不直接收入倉庫。
- 影片只寫觀看摘要與學到的流程，不搬運影片。

## 萬龍覺醒應用覆蓋

| 能力 | 對應筆記 | 萬龍用途 |
|---|---|---|
| 狀態機 | `architecture.md`, `flow-ui-variable-notes.md` | 城內、野外、搜尋、採集、行軍、恢復 |
| OCR | `visual-recognition-notes.md`, `zdjl-api-cheatsheet.md` | 資源等級、提示文字、倒計時 |
| 找圖/找色 | `visual-recognition-notes.md` | 按鈕、資源圖標、進度條 |
| 文件與日誌 | `file-api-log-notes.md` | config/state/log/error screenshots |
| 環境穩定 | `environment-stability-notes.md` | 紅手指、模擬器、OCR ERROR |
| 節點 | `node-app-automation-notes.md` | 權限彈窗、截圖授權、外層 UI |
| AI 審核 | `ai-assisted-script-notes.md` | 生成狀態機、審核代碼、分類錯誤 |
| 動作組 | `action-expression-dsl-notes.md` | 拆分可測動作、JS 調度、變量寫回 |
| UI/Markdown | `ui-markdown-dialog-notes.md` | 配置頁、狀態面板、彈窗預設分支、多套配置 |
| Prompt 與範例 | `prompts/`, `examples/`, `tests/fixtures/` | 反覆產生狀態機、代碼審核與虛擬測試資料 |
| 虛擬測試 | `virtual_test_flow.md` | 用截圖測流程，不直接盲跑 |
| 後端安全模板 | `backend-security-review.md`, `update-manifest.example.json`, `backend-api-contract.example.json` | 發布前檢查授權、熱更新、遠端配置是否脫敏 |

## 仍需繼續深讀

分類 3 已全量索引與打開，但不是每篇都已寫成專題摘要。`sources/category-3-topic-coverage.md` 目前標記 177 篇已進入專題筆記、來源摘要層 0、132 篇尚未專題化；後續要以這張表為準逐批補齊。

PowerShell 直連論壇可能失敗；先前 Node/Chrome 式請求已確認能讀 source-00 到 c3-03。2026-06-19 續讀 c3-04 時 Codex 可用路徑出現 504/連線問題，所以後續批次必須等可讀來源恢復後再補。

分類 4 目前暫停，不再安排後續深讀。

- 二次深讀高價值候選 1565 篇。
- 節點/控件候選約 399 篇的第二批。
- 環境/穩定性擴大候選約 741 篇的第二批。
- 文件/API/日誌候選約 505 篇的第二批。
- 條件/跳轉/監聽候選約 764 篇的第二批。
- 視覺識別、找圖、找色、OCR 候選的後續批次。
- 後端、熱更新、卡密、用戶管理候選要繼續做安全摘要。

## 發布前檢查命令

可在工作區執行：

```powershell
rg "API key|token|cookie|密鑰|密钥|卡密算法|管理地址|私有接口" README.md docs sources prompts examples tests
rg "created_at >= 2024-01-01|309 / 309|3535|category-3-full-manifest" README.md docs sources prompts examples tests
rg "<先前排除的舊分類4來源ID>" README.md docs sources prompts examples tests
.\tools\verify-category3-coverage.ps1
.\tools\export-learned-traceability.ps1
.\tools\export-learning-status.ps1
.\tools\export-study-queue.ps1
.\tools\verify-deep-read-records.ps1
.\tools\verify-source-attribution.ps1
.\tools\verify-github-package.ps1
.\tools\verify-learning-library.ps1
.\tools\probe-zdjl-forum.ps1
.\tools\sync-zdjl-forum.ps1 -CategoryIds 3 -MaxPages 1 -OutputDir sources/raw-smoke
.\tools\build-study-queue.ps1 -RawDir sources/raw-smoke -OutputPath sources/study-queue.generated.md
```

解讀：

- 第一條命令命中時要判斷是否只是安全提醒；不得有真實密鑰。
- 第二條命令應能看到分類規則和覆蓋證據。
- 第三條命令不應命中，這些是先前排除的舊分類 4 來源 ID。
- `verify-category3-coverage.ps1` 應輸出 `missing_count = 0`、`extra_count = 0`、`duplicate_count = 0`。
- `export-learned-traceability.ps1` 應產生 `sources/learned-thread-traceability.json`，目前應追查 177 個唯一已學 Thread ID。
- `export-learning-status.ps1` 應產生 `sources/learning-status.generated.json`，供 GitHub 與本機直接讀取進度數字。
- `export-study-queue.ps1` 應產生 `sources/study-queue.full.generated.md/json`，供後續深讀照批次施工。
- `verify-deep-read-records.ps1` 用於檢查每篇 deep-read note；目前可接受「尚無正式紀錄」警告，但不能有 failure。
- `verify-source-attribution.ps1` 用於檢查來源 URL、來源範圍、deep-read 模板與公開整理政策。
- `verify-github-package.ps1` 用於檢查 GitHub 發布包，確認必備文件、忽略規則、公開檔案大小與敏感格式。
- `verify-learning-library.ps1` 應輸出 `ok = true`；若要測論壇外部狀態，改用 `verify-learning-library.ps1 -CheckForum`。
- `probe-zdjl-forum.ps1` 只用於判斷論壇是否恢復；若失敗，不能把待讀批次標記為已完成。
- `sync-zdjl-forum.ps1` 的 smoke test 只驗證同步流程可用；同步成功不等於文章已深讀。
- `build-study-queue.ps1` 用於產生待讀清單；清單存在不等於深讀完成。

## GitHub 倉庫建議結構

```text
.gitignore
.github/workflows/verify-learning-library.yml
.github/PULL_REQUEST_TEMPLATE.md
.github/ISSUE_TEMPLATE/
CONTRIBUTING.md
START_HERE.md
README.md
SECURITY.md
virtual_test_flow.md
docs/
sources/
prompts/
tests/fixtures/
examples/
tools/
templates/
```

已新增第一版：

- `.gitignore`
- `.github/workflows/verify-learning-library.yml`
- `.github/PULL_REQUEST_TEMPLATE.md`
- `.github/ISSUE_TEMPLATE/deep-read-batch.md`
- `.github/ISSUE_TEMPLATE/source-attribution-review.md`
- `.github/ISSUE_TEMPLATE/forum-recovery-sync.md`
- `CONTRIBUTING.md`
- `SECURITY.md`
- `START_HERE.md`
- `docs/tutorial-learning-roadmap.md`
- `docs/progress-dashboard.md`
- `docs/forum-sync-workflow.md`
- `docs/deep-read-protocol.md`
- `docs/source-attribution-policy.md`
- `docs/completion-audit.md`
- `docs/github-actions-ci.md`
- `docs/github-publishing-checklist.md`
- `docs/github-upload-guide.md`
- `sources/deep-read-ledger.md`
- `sources/learning-status.generated.json`
- `sources/study-queue.full.generated.md`
- `sources/study-queue.full.generated.json`
- `sources/category-4-continuation-plan.md`
- `templates/deep-read-note.md`
- `templates/batch-review-report.md`
- `prompts/wanlong-state-machine.md`
- `prompts/code-review.md`
- `prompts/backend-security-review.md`
- `tests/fixtures/README.md`
- `examples/wanlong-config.example.json`
- `examples/wanlong-state.example.json`
- `examples/update-manifest.example.json`
- `examples/backend-api-contract.example.json`
- `tools/probe-zdjl-forum.ps1`
- `tools/sync-zdjl-forum.ps1`
- `tools/build-study-queue.ps1`
- `tools/export-learning-status.ps1`
- `tools/export-study-queue.ps1`
- `tools/verify-learning-library.ps1`
- `tools/verify-category3-coverage.ps1`
- `tools/verify-deep-read-records.ps1`
- `tools/verify-github-package.ps1`
- `tools/verify-source-attribution.ps1`

## 完成定義

此學習庫要宣稱「完整」前，至少要滿足：

- 分類 3 的 309 篇都有 manifest、來源連結、主題歸類，且 `sources/category-3-topic-coverage.md` 的「尚未專題化」歸零，`sources/category-3-continuation-plan.md` 沒有未完成批次。
- 分類 4 不列入完成條件，除非使用者重新要求恢復。
- 每個高價值候選都有摘要或明確排除理由。
- 所有專題都有來源 ID。
- 敏感內容已脫敏。
- 萬龍腳本能從筆記映射到測試流程與實作規格。

目前狀態：source-00、c3-01、c3-02 與 c3-03 已完成正式深讀，但分類 3 還有 132 篇待專題化，因此不標記為最終完成。
