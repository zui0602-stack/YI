# 自動精靈完整學習庫總索引

這份文件是 GitHub 版入口。目標不是把論壇原文搬過來，而是把所有教程、教學、代碼、架設、問答解法整理成可長期維護的原創知識庫。

## 收錄規則

| 分類 | 收錄範圍 | 規則 |
|---|---|---|
| 分类 3 软件使用教程 | 全量 309 篇 | 正式教程區，不管年份全部學習與整理 |
| 分类 4 软件使用交流 | 已暫停 | 2026-06-18 使用者要求不再學，既有筆記只作歷史參考 |
| 影片 / 外部連結 | 需二次確認 | 區分教學影片、源碼附件、示例腳本、展示錄屏 |
| 代碼 / 源碼 | 原創整理 | 不整段搬運，整理成架構、模式、注意事項與脫敏片段 |
| 卡密 / 後端 / 接口 | 安全整理 | 不公開密鑰、管理地址、可濫用抓包細節 |

## 覆蓋總覽

| 項目 | 數量 | 狀態 |
|---|---:|---|
| 分类 3 索引 | 309 / 309 | 已完整收集 |
| 分类 3 詳情頁 | 309 / 309 | 已逐篇打開稽核 |
| 分类 4 API 索引 | 歷史參考 | 已暫停 |
| 分类 4 有效範圍 | 暫停 | 不再列入完成條件 |
| 分类 4 高價值候選 | 暫停 | 不再續讀 |
| 分类 4 已整理代表問答 | 歷史參考 | 不再擴充 |

## 主題分佈

### 分类 3 教程區

| 主題 | 命中數 |
|---|---:|
| 教程 / 教學 / 入門 | 244 |
| 代碼 / JS / 表達式 / 變量 | 258 |
| OCR / 找圖 / 找色 / 坐標 / 節點 | 183 |
| 流程 / 條件 / 跳轉 / 循環 / 監聽 | 266 |
| 文件 / 日誌 / API / 網路 | 155 |
| 後端 / 卡密 / 熱更新 / 用戶管理 | 107 |
| 環境 / 權限 / 模擬器 / 異常 | 59 |
| 影片 / 錄屏線索 | 47 |

### 分类 4 交流區

| 主題 | 命中數 |
|---|---:|
| 教學 / 問答 / 求助 | 2189 |
| 代碼 / JS / 表達式 / 變量 | 728 |
| OCR / 找圖 / 找色 / 坐標 / 節點 | 940 |
| 流程 / 條件 / 跳轉 / 循環 / 監聽 | 1422 |
| 文件 / 日誌 / API / 網路 | 291 |
| 後端 / 卡密 / 熱更新 / 用戶管理 | 87 |
| 環境 / 權限 / 模擬器 / 異常 | 419 |
| 影片 / 錄屏線索 | 55 |

## 文件入口

### 開始學習

- `START_HERE.md`：第一個入口，說明目前哪些內容可學、學習順序、尚未完成項目與檢查方式。
- `docs/tutorial-learning-roadmap.md`：完整學習路線，把論壇教程轉成階段式課程與練習。
- `docs/progress-dashboard.md`：目前進度、可學內容、待補批次、論壇狀態與檢查結果。
- `docs/forum-sync-workflow.md`：如何同步分類 3、抓文章詳情、抓回覆、轉成專題筆記與回填覆蓋表。
- `docs/deep-read-protocol.md`：逐篇深讀完成標準、狀態值、代碼/影片/附件處理規則。
- `docs/completion-audit.md`：把原始需求拆成可檢查項目，記錄目前證據與未完成原因。

### 架構與核心能力

- `docs/github-publishing-checklist.md`：GitHub 發布、來源覆蓋、敏感內容、安全收錄、萬龍應用與完成定義清單。
- `docs/architecture.md`：自動精靈大型腳本架構、狀態機、萬龍覺醒採集流程。
- `docs/js-api-notes.md`：官方 JS/API、變量、找座標、OCR、網路、文件能力。
- `docs/zdjl-api-cheatsheet.md`：JS/API 速查表、常用能力、失敗模式、審核規則與萬龍最小 API 組合。
- `docs/action-expression-dsl-notes.md`：動作表達式、`runAction/runActionAsync`、腳本動作變量、函數封裝、子腳本參數、動態動作、ZEasyAction、UI DSL 與萬龍動作組設計。
- `docs/ui-markdown-dialog-notes.md`：設定變量 UI、顯示/隱藏、分頁、單選/多選、Markdown、動態彈窗、ZEasyUI、Kodex、HTML-UI 與萬龍配置界面。
- `docs/core-tutorial-notes.md`：分類 3 核心教程閱讀筆記。
- `docs/flow-ui-variable-notes.md`：流程控制、監聽、循環、UI、變量、配置保存與萬龍狀態機。
- `docs/condition-jump-listener-notes.md`：條件判斷、跳轉標識、全局監聽、突發事件與卡死排查。
- `docs/file-api-log-notes.md`：文件讀寫、JSON 配置、storage、網路請求、截圖保存、上傳下載與日誌。
- `docs/environment-stability-notes.md`：權限、無障礙、模擬器、紅手指、OCR ERROR、識別卡死、停止保護與長時間運行。
- `docs/node-app-automation-notes.md`：節點、控件、普通 App、剪貼板、輸入框、權限彈窗、列表滑動與節點不可用降級。
- `docs/ai-assisted-script-notes.md`：AI 輔助腳本、prompt 強約束、知識庫、代碼審核、AI 圖片理解、依賴限制與 GitHub 安全收錄。
- `docs/tutorial-map.md`：分類、主題、已讀與待讀地圖。

### 分类 4 歷史參考

- `docs/category-4-first-pass-notes.md`：第一批與第二批問答整理。
- `docs/category-4-deep-dive-2024.md`：2024 後高價值問答深讀，包含 AI、OCR、節點、URL、UI、npm、模擬器等。

### 後端與架設

- `docs/backend-deployment-notes.md`：Supabase、PHP/MySQL、Node/Express/Mongo、熱更新、卡密、遠程 OCR。
- `docs/visual-recognition-notes.md`：OCR、找圖、找色、坐標、進度條與遊戲視覺識別。
- `docs/file-api-log-notes.md`：文件、API、日誌與資料保存。
- `examples/update-manifest.example.json`：熱更新 manifest 假資料。
- `examples/backend-api-contract.example.json`：後端 API 成功、錯誤與授權回應格式假資料。

### 環境與穩定性

- `docs/environment-stability-notes.md`：Android 受限制設定、無障礙、root 模式、MuMu/雷電/紅手指、OCR ERROR、截圖黑屏、半屏識別、停止不了與長時間掛機保護。

### 節點與普通 App

- `docs/node-app-automation-notes.md`：`findNode`、正則節點、節點快取、text/desc/children、剪貼板、輸入框、系統權限彈窗、列表滑動與普通 App 控件策略。

### AI 輔助與代碼審核

- `docs/ai-assisted-script-notes.md`：AI prompt 強約束、知識庫材料、代碼審核清單、AI 圖片理解、npm/依賴限制、DSL/UI 庫風險與萬龍 AI 工作流。

### UI 與配置界面

- `docs/ui-markdown-dialog-notes.md`：設定變量 UI、分頁、單選/多選、Markdown 表格、狀態面板、彈窗生命週期、ZEasyUI、Kodex、HTML-UI 與設備兼容限制。

### API 速查

- `docs/zdjl-api-cheatsheet.md`：`getVar/setVar`、storage、剪貼板、節點、坐標、OCR、找圖找色、網路、文件、日誌、動作調用與 UI 彈窗的快速查表。
- `docs/action-expression-dsl-notes.md`：動作 JSON、條件檢查、動作變量、批量動作、異步、子腳本參數、動態動作和 DSL 的實戰筆記。

### Prompt、範例與測試模板

- `prompts/wanlong-state-machine.md`：把截圖、已驗證動作和變量表轉成萬龍採集狀態機、測試表與風險清單的 prompt。
- `prompts/code-review.md`：審核自動精靈 JS、動作表達式和萬龍流程的問題優先 prompt。
- `prompts/backend-security-review.md`：審核後端、卡密、熱更新、遠端配置與遠端 OCR 是否可安全公開的 prompt。
- `examples/wanlong-config.example.json`：不含密鑰與私人資料的萬龍採集配置假資料。
- `examples/wanlong-state.example.json`：不含私人資料的萬龍採集運行狀態假資料。
- `examples/update-manifest.example.json`：不含真實下載私鏈的熱更新 manifest 假資料。
- `examples/backend-api-contract.example.json`：不含真實接口的後端 API contract 假資料。
- `tests/fixtures/README.md`：虛擬測試截圖命名、標註 JSON 與必備場景規格。
- `templates/deep-read-note.md`：逐篇論壇文章深讀記錄模板。
- `templates/batch-review-report.md`：批次驗收報告模板。
- `tools/probe-zdjl-forum.ps1`：論壇恢復探測工具，用於確認分類頁、API 與單篇頁是否可讀。
- `tools/sync-zdjl-forum.ps1`：論壇同步工具，用於保存分類索引、指定文章詳情與回覆原始 JSON。
- `tools/build-study-queue.ps1`：深讀隊列工具，用於把 raw JSON 或現有分類 3 覆蓋表轉成待讀清單。
- `tools/new-deep-read-note.ps1`：逐篇記錄產生工具，用於為單一 Thread ID 建立標準 deep-read 檔案。
- `tools/verify-learning-library.ps1`：一鍵驗證工具，用於檢查必要檔案、格式、JSON、覆蓋表、深讀隊列與 `.gitignore`。
- `tools/verify-category3-coverage.ps1`：分類 3 覆蓋驗證工具，用於檢查 309 個 ID 是否無遺漏、無重複、無多餘。

### 影片與媒體

- `docs/video-tutorial-notes.md`：分類 3 影片線索二次分類。

### 來源與覆蓋

- `docs/github-publishing-checklist.md`：發布前驗收與覆蓋稽核。
- `sources/category-3-api-scan.md`：分類 3 全量教程 API 掃描摘要。
- `sources/category-3-continuation-plan.md`：分類 3 來源摘要層與尚未專題化 ID 的續讀批次表。
- `sources/category-3-full-manifest.md`：分類 3 正式教程 309 篇全量 Thread ID manifest。
- `sources/category-3-topic-coverage.md`：分類 3 全量教程反向主題覆蓋追蹤表。
- `sources/category-3-tutorial-index.md`：分類 3 首批、末批、核心優先帖。
- `sources/category-3-opened-audit.md`：分類 3 逐篇打開稽核。
- `sources/category-4-api-scan.md`：分類 4 歷史索引，已停止後續學習。
- `sources/category-4-continuation-plan.md`：分類 4 歷史續讀計畫，目前暫停。
- `sources/category-4-partial-scan.md`：分類 4 早期網頁滾動掃描歷史記錄。
- `sources/deep-read-ledger.md`：深讀批次帳本，追蹤每個批次是否完成、阻塞或待處理。
- `sources/deep-reads/README.md`：逐篇 deep-read 記錄的存放位置與規則。

## 學習庫主題分類

後續每篇教程或問答都會歸入至少一個主題：

- JS/API：官方 API、`runAction`、`findLocation`、`recognitionScreen`、網路請求。
- 變量與存儲：作用域、全局變量、本地存儲、配置持久化。
- OCR/視覺識別：文字識別、數字比較、找圖、找色、多色、進度條。
- 節點與普通 App：節點查找、節點快取、權限彈窗、App 操作。
- 流程控制：條件、跳轉、監聽、循環、定時、失敗恢復。
- UI：設置界面、分頁 UI、Markdown、彈窗、狀態面板。
- 文件與日誌：讀寫 txt、截圖保存、圖片變量、運行日誌。
- 後端與架設：熱更新、卡密、用戶管理、遠端配置、OCR 服務。
- 環境排錯：紅手指、模擬器、Root、無障礙、黑屏、OCR ERROR。
- AI 輔助：prompt 約束、知識庫、AI 生成代碼審核規則。

## 對萬龍覺醒腳本的應用方式

這個學習庫最終要服務腳本修改與測試：

- OCR/找圖/找色筆記用於採集、行軍、角色切換、資源搜尋。
- 流程控制筆記用於失敗重試、狀態機、長時間運行穩定性。
- 變量與存儲筆記用於角色列表、隊列、配置、多帳號。
- UI 與配置筆記用於資源種類、角色列表、偵錯面板、坐標校準與多套方案。
- 文件與日誌筆記用於 config/state/log、錯誤截圖保存與虛擬測試報告。
- 後端與熱更新筆記用於未來發布、版本更新、授權與遠程配置。
- 環境排錯筆記用於紅手指、模擬器、OCR 兼容模式、停止保護、失敗截圖與設備矩陣。
- 節點筆記用於處理系統權限、截圖授權、紅手指外層 UI，以及萬龍啟動前的環境自檢。
- AI 筆記用於產生萬龍狀態機、虛擬測試表、錯誤分類與小函數初稿，但所有代碼必須再實測。
- API 速查表用於審核萬龍腳本中每個函式是否有判空、降級、日誌與安全邊界。
- 動作/表達式 DSL 筆記用於把萬龍流程拆成可測動作組，並檢查 JS 調度是否有等待、失敗出口與變量寫回。
- UI/Markdown 筆記用於建立萬龍配置頁、偵錯狀態面板、彈窗超時分支與多套配置，不讓 UI 阻塞核心採集流程。
- Prompt 與 examples 用於把論壇學到的架構轉成可反覆審核的輸入資料，而不是每次從頭描述。
- 後端安全 prompt 與 examples 用於發布前檢查是否誤放真實 key、卡密、管理地址、後台接口或可直接執行的遠端代碼。

## 版權與安全

- 保留來源連結。
- 不整篇複製論壇內容。
- 不公開敏感接口、密鑰、卡密算法和管理地址。
- 代碼以脫敏模板、偽代碼、架構模式為主。
- 商業或他人源碼只記錄「學到的架構」，不搬運完整實作。
