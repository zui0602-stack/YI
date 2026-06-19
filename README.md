# 自動精靈學習筆記

這個資料夾用來整理自動精靈論壇教學、代碼、架設方式與腳本架構理解，目標是做成可放到 GitHub 的原創學習筆記。

## 先從這裡開始

- `START_HERE.md`：學習庫入口，適合要開始學或要放 GitHub 前先看。
- `docs/tutorial-learning-roadmap.md`：照主題安排的學習順序，從架構、API、流程、OCR、UI 到後端發布。
- `docs/progress-dashboard.md`：目前完成度、待補批次、論壇狀態與最新檢查結果。
- `docs/forum-sync-workflow.md`：分類 3 同步、抓文章詳情、抓回覆與回填覆蓋表的工作流；分類 4 已暫停。
- `docs/deep-read-protocol.md`：逐篇深讀完成標準、狀態值、代碼/影片/附件處理規則。
- `docs/source-attribution-policy.md`：來源歸因、公開整理與不搬運原文/完整源碼的規則。
- `docs/completion-audit.md`：把使用者要求拆成可檢查項目，避免誤判完成。
- `docs/current-status-report.md`：人工檢查用短版進度總覽，彙整目前數字、驗證結果、論壇狀態與下一步。
- `docs/github-actions-ci.md`：GitHub Actions 自動驗證流程與紅燈排查方式。
- `docs/github-upload-guide.md`：GitHub 倉庫描述、上傳前驗證、可公開與不可公開內容。
- `docs/learning-library-index.md`：完整文件索引與收錄規則。

## 來源

- 软件使用教程：<https://bbs.zdjl.site/#/thread/category/3>
- 软件使用交流：<https://bbs.zdjl.site/#/thread/category/4>

## 目前進度

- 已完整盤點「软件使用教程」分類：309 / 309 篇帖子索引；教程區不套日期排除，309 篇全部納入學習。
- 已逐篇打開「软件使用教程」309 / 309 篇文章詳情頁，檢查正文、代碼區塊、圖片、媒體標籤、外鏈與影片線索，打開錯誤 0 篇。
- 已新增分類 3 主題覆蓋追蹤表：目前 177 篇分類 3 ID 已進入專題筆記，來源摘要層已歸零，132 篇列入下一批專題化隊列。
- 已閱讀官方「运行 JS 代码」文檔與第一批核心教學。
- 已依 2026-06-18 最新指令停止分類 4 後續學習；分類 4 既有索引與筆記只保留為歷史參考，不再列入完成條件。
- 已整理「流程控制、UI 與變量」專題，納入循環、監聽、動作鎖、定時、失敗回復、配置保存與萬龍採集狀態機。
- 已整理「條件、跳轉與監聽」專題，納入條件閘門、跳轉標識、全局監聽限制、突發事件、OCR 空值與卡死排查。
- 已整理「文件、API、日誌與資料保存」專題，納入文件讀寫、JSON 配置、storage、網路請求、上傳下載限制、截圖保存與日誌排錯。
- 已整理「環境、權限、模擬器與穩定性」專題，納入無障礙受限、root/無障礙衝突、MuMu/雷電/紅手指、OCR ERROR、識別卡死、停止保護與長時間運行設計。
- 已整理「節點、控件、普通 App 與剪貼板」專題，納入 `findNode`、正則查找、節點快取、text/desc/children 提取、輸入框、權限彈窗與節點不可用降級策略。
- 已整理「AI 輔助腳本、prompt 強約束與代碼審核」專題，納入 AI 生成代碼規範、知識庫、環境錯配、OCR/坐標/變量審核、依賴限制與 GitHub 安全收錄規則。
- 已新增「JS/API 速查表」，把 `getVar/setVar`、storage、剪貼板、`findNode`、`findLocation`、OCR、網路請求、文件日誌、動作調用與萬龍最小 API 組合整理成可查表的 GitHub 文件。
- 已整理「動作、表達式與 DSL」專題，納入 `runAction/runActionAsync`、`check/checkAsync`、腳本動作變量、函數封裝、子腳本參數、動態動作、ZEasyAction、UI DSL 與萬龍動作組設計。
- 已整理「UI、Markdown、彈窗與配置界面」專題，納入設定變量 UI、分頁、單選/多選、Markdown 狀態面板、動態彈窗、ZEasyUI、Kodex、HTML-UI、鍵盤遮擋與萬龍配置界面建議。
- 已補強「後端、架設、卡密與熱更新」專題，新增安全版 API contract、熱更新 manifest、授權回應格式、版本比較、Supabase key 分層與萬龍後端演進路線。
- 已新增 GitHub 可用模板：萬龍狀態機 prompt、代碼審核 prompt、範例 config/state、虛擬測試截圖規格。
- 已新增 GitHub 發布包檢查：必備文件、忽略規則、公開檔案大小、附件類型與疑似 secret 格式。
- 已新增 GitHub Actions 驗證流程，push/PR 後會自動跑本地驗證工具。
- 已新增 GitHub PR 與 Issue 模板，用來追蹤深讀批次、來源歸因審核與論壇恢復同步。
- 已新增機器可讀進度摘要 `sources/learning-status.generated.json`，可直接檢查分類 3/4 數字、GitHub readiness 與未完成原因。
- 已新增完整深讀隊列 `sources/study-queue.full.generated.md/json`，目前只列出分類 3 的 132 篇待專題化；分類 4 已暫停。
- 已新增來源歸因檢查，要求保留來源 ID/URL、深讀記錄與公開安全整理規則。
- 正在持續補齊自動精靈的 JS API、變量、OCR、找座標、找節點、網路請求、文件讀寫、動作調用、UI、熱更新、卡密與後端架設等架構。

## 文件結構

- `docs/learning-library-index.md`：GitHub 版完整學習庫總入口、收錄規則與覆蓋狀態。
- `docs/tutorial-learning-roadmap.md`：自動精靈教程學習順序、每階段練習與萬龍套用路線。
- `docs/progress-dashboard.md`：目前可學內容、未完成批次、後續讀取順序與檢查結果。
- `docs/forum-sync-workflow.md`：論壇 API 同步、原始 JSON 保存、深讀與回填流程。
- `docs/deep-read-protocol.md`：每篇文章如何從來源、回覆、代碼、附件轉成可公開筆記的規範。
- `docs/source-attribution-policy.md`：來源歸因、改寫標準、可公開與不可公開內容。
- `docs/completion-audit.md`：完成度稽核、缺口與驗證方式。
- `docs/current-status-report.md`：目前進度、卡點與下一步施工順序。
- `docs/github-actions-ci.md`：GitHub Actions 自動驗證流程、檢查項目與失敗排查。
- `docs/github-publishing-checklist.md`：GitHub 發布、覆蓋稽核、安全收錄與完成定義檢查清單。
- `docs/github-upload-guide.md`：GitHub 上傳前檢查、倉庫描述、可公開範圍與後續深讀流程。
- `docs/architecture.md`：自動精靈整體架構理解。
- `docs/js-api-notes.md`：官方 JS/表達式/API 學習筆記。
- `docs/zdjl-api-cheatsheet.md`：自動精靈 JS/API 速查表、常用能力、坑點與萬龍最小 API 組合。
- `docs/action-expression-dsl-notes.md`：動作表達式、JS 調動作、腳本動作變量、動態動作、ZEasyAction 與 UI DSL 筆記。
- `docs/ui-markdown-dialog-notes.md`：設定變量 UI、Markdown、分頁、單選、多套配置、動態彈窗、ZEasyUI、Kodex 與萬龍配置界面筆記。
- `docs/core-tutorial-notes.md`：核心教學帖閱讀筆記。
- `docs/video-tutorial-notes.md`：影片教學與媒體類文章的二次分類筆記。
- `docs/category-4-first-pass-notes.md`：软件使用交流分類第一批問答型教學筆記。
- `docs/category-4-deep-dive-2024.md`：软件使用交流分類 2024 後高價值問答深讀筆記。
- `docs/backend-deployment-notes.md`：後端、架設、卡密、熱更新與遠程 OCR 筆記。
- `docs/visual-recognition-notes.md`：OCR、找圖、找色、坐標、進度條與遊戲視覺識別筆記。
- `docs/flow-ui-variable-notes.md`：流程控制、監聽、循環、UI、變量、配置保存與萬龍狀態機筆記。
- `docs/condition-jump-listener-notes.md`：條件判斷、跳轉標識、全局監聽、突發事件與卡死排查筆記。
- `docs/file-api-log-notes.md`：文件讀寫、JSON 配置、storage、網路請求、截圖保存、上傳下載與日誌筆記。
- `docs/environment-stability-notes.md`：權限、無障礙、模擬器、紅手指、OCR ERROR、卡死與停止保護筆記。
- `docs/node-app-automation-notes.md`：節點、控件、普通 App、剪貼板、輸入框、權限彈窗與節點降級策略筆記。
- `docs/ai-assisted-script-notes.md`：AI 輔助腳本、prompt 強約束、知識庫、代碼審核、依賴限制與 GitHub 安全收錄筆記。
- `docs/tutorial-map.md`：教學主題地圖與覆蓋狀態。
- `sources/category-3-api-scan.md`：软件使用教程分類全量 API 掃描摘要。
- `sources/category-3-continuation-plan.md`：软件使用教程待專題化批次、論壇錯誤斷點與續讀標準。
- `sources/category-3-full-manifest.md`：软件使用教程 309 篇全量 Thread ID 清單與頭尾核對。
- `sources/category-3-topic-coverage.md`：软件使用教程 309 篇反向主題覆蓋追蹤表。
- `sources/category-3-tutorial-index.md`：软件使用教程分類索引與覆蓋記錄。
- `sources/category-3-opened-audit.md`：软件使用教程逐篇打開稽核摘要、影片線索與架設/API 清單。
- `sources/category-4-api-scan.md`：软件使用交流分類 API 全量索引與歷史候選統計。
- `sources/category-4-continuation-plan.md`：软件使用交流分類歷史續讀計畫；目前已依使用者要求暫停。
- `sources/category-4-partial-scan.md`：软件使用交流分類部分索引掃描、候選主題與限制說明。
- `sources/deep-read-ledger.md`：深讀批次帳本，追蹤 source-00、c3 批次；分類 4 標記為使用者要求暫停。
- `sources/deep-reads/README.md`：逐篇 deep-read 記錄的存放規則。
- `sources/learning-status.generated.json`：機器可讀進度摘要，由 `tools/export-learning-status.ps1` 產生。
- `sources/learned-tutorial-classification.json`：已學教程的機器可讀分類索引。
- `sources/learned-thread-traceability.json`：已學 Thread ID 到專題文件的可追查索引。
- `sources/study-queue.full.generated.md`：完整深讀隊列的人類可讀版。
- `sources/study-queue.full.generated.json`：完整深讀隊列的機器可讀版。
- `prompts/wanlong-state-machine.md`：萬龍採集狀態機與虛擬測試 prompt。
- `prompts/code-review.md`：自動精靈 JS / 動作表達式代碼審核 prompt。
- `prompts/backend-security-review.md`：後端、卡密、熱更新與遠端配置安全審核 prompt。
- `examples/wanlong-config.example.json`：萬龍採集配置假資料。
- `examples/wanlong-state.example.json`：萬龍採集運行狀態假資料。
- `examples/update-manifest.example.json`：熱更新 manifest 假資料。
- `examples/backend-api-contract.example.json`：後端 API 回應格式假資料。
- `tests/fixtures/README.md`：虛擬測試截圖與標註規格。
- `templates/deep-read-note.md`：逐篇文章深讀記錄模板。
- `templates/batch-review-report.md`：批次深讀驗收報告模板。
- `tools/probe-zdjl-forum.ps1`：論壇恢復探測工具。
- `tools/sync-zdjl-forum.ps1`：論壇分類索引、文章詳情與回覆同步工具。
- `tools/build-study-queue.ps1`：把 raw JSON 或既有覆蓋表轉成待深讀隊列。
- `tools/export-learning-status.ps1`：匯出機器可讀進度摘要。
- `tools/export-study-queue.ps1`：匯出完整深讀隊列。
- `tools/export-learned-traceability.ps1`：從分類 3 覆蓋表匯出已學 Thread ID 追查索引。
- `tools/new-deep-read-note.ps1`：為單篇論壇文章產生標準 deep-read 記錄。
- `tools/verify-learning-library.ps1`：一鍵驗證必要檔案、格式、JSON、覆蓋表、深讀隊列與 GitHub 忽略規則。
- `tools/verify-category3-coverage.ps1`：分類 3 覆蓋表驗證工具。
- `tools/verify-deep-read-records.ps1`：逐篇 deep-read 記錄驗證工具。
- `tools/verify-github-package.ps1`：GitHub 發布包驗證工具。
- `tools/verify-source-attribution.ps1`：來源歸因與公開整理規則驗證工具。
- `virtual_test_flow.md`：萬龍覺醒腳本虛擬測試流程。

## 版權說明

本倉庫會保留來源連結，內容以原創整理、架構理解、用法歸納為主，不整篇搬運論壇文章或完整複製他人代碼。若需要收錄完整原文或完整源碼，應先取得作者授權。
## 2026-06-19 Access Note

- Active scope is Category 3 only; Category 4 remains paused.
- c3-04 is the next batch, but the forum currently returns 504/connection errors from the available Codex access paths.
- c3-04 is not marked learned or specialized.
- Recovery details are tracked in `sources/category-3-c3-04-access-log.md`.

## 2026-06-19 Learned Content Classification

- Already learned content no longer needs extra date work.
- Use `docs/learned-tutorial-classification.md` as the first clean index for learned tutorials by topic and usage.
- Use `sources/learned-tutorial-classification.json` when a script or AI tool needs the same index in machine-readable form.
- Use `sources/learned-thread-traceability.json` to verify which learned Thread IDs feed each topic document.
- Dates are only needed for unread threads when deciding whether to skip a cutoff range.
