# 已學教程分類總表

更新日期：2026-06-19 Asia/Taipei

這份文件只整理「已經學好的內容」。已學內容不再補查日期；日期只用在未學文章是否要排除的判斷。現在的重點是把已學內容整理成可查、可放 GitHub、可拿來做腳本設計與後續訓練的分類庫。

機器可讀版：`sources/learned-tutorial-classification.json`

已學 Thread ID 追查索引：`sources/learned-thread-traceability.json`

## 目前狀態

| 項目 | 狀態 |
|---|---|
| 第 3 類教程總清單 | 309 篇已建索引 |
| 已整理進專題筆記 | 177 篇 |
| 正式 deep-read 紀錄 | 71 篇 |
| 來源摘要待補 | 0 篇 |
| 尚未專題化 | 132 篇 |
| 第 4 類 | 已依使用者要求暫停後續學習，只保留既有歷史筆記 |

## 已學內容處理規則

- 已學好的教程不再補日期。
- 已學好的教程只做分類、去重、摘要、用途整理。
- 未學教程如果要判斷是否跳過，才需要抓 `created_at`。
- 沒讀到正文、回覆、影片或附件的文章，不能標成已學。
- 可放 GitHub 的版本只保留方法、架構、流程與安全摘要，不搬完整付費內容、私密資料、token、帳密、可濫用繞過步驟。

## 分類索引

| 分類 | 已學重點 | 主要筆記 |
|---|---|---|
| 入門與核心觀念 | 自動精靈整體操作、腳本結構、常見功能入口、基本 API 思路 | `docs/core-tutorial-notes.md`, `docs/js-api-notes.md`, `docs/category-3-source-00-deep-read.md` |
| JS/API 速查 | 變數、Storage、節點查找、OCR、HTTP、檔案、日誌、動作呼叫的可重用 API 摘要 | `docs/zdjl-api-cheatsheet.md`, `docs/file-api-log-notes.md` |
| 動作表達式與 DSL | `runAction`、動作表達式、參數傳遞、子腳本、ZEasyAction、UI DSL 的拆解方式 | `docs/action-expression-dsl-notes.md` |
| 流程控制與變數 | 條件、跳轉、列表、監聽、狀態變數、流程分支、任務狀態機 | `docs/flow-ui-variable-notes.md`, `docs/condition-jump-listener-notes.md` |
| UI / Markdown / Dialog | 自訂 UI、Markdown 介面、表單、彈窗、HTML/UI、ZEasyUI、Codex/Kodex 類工具用法 | `docs/ui-markdown-dialog-notes.md` |
| OCR / 找圖 / 視覺識別 | OCR、找圖、找色、座標、截圖、畫面辨識策略、遊戲/自繪畫面判斷 | `docs/visual-recognition-notes.md`, `docs/video-tutorial-notes.md` |
| 檔案、日誌、資料保存 | JSON、txt、Storage、log、配置檔、輸出結果、資料讀寫與除錯 | `docs/file-api-log-notes.md` |
| Node / App 自動化 | Node 環境、App 節點查找、文字/描述/children、頁面操作與結構化定位 | `docs/node-app-automation-notes.md` |
| 後端與部署 | Supabase、PHP/MySQL、Node/Express/Mongo、API contract、授權與伺服器交互 | `docs/backend-deployment-notes.md`, `examples/backend-api-contract.example.json` |
| 環境與穩定性 | root、模擬器、權限、OCR ERROR、腳本卡住、安裝/相容性、執行環境排查 | `docs/environment-stability-notes.md` |
| AI 輔助寫腳本 | Prompt、知識庫、AI 生成腳本、AI 審查、把教程變成可查問答/訓練資料 | `docs/ai-assisted-script-notes.md`, `prompts/code-review.md` |
| 萬龍覺醒腳本應用 | 虛擬測試流程、採集狀態機、畫面狀態、測試資料與腳本設計方向 | `virtual_test_flow.md`, `prompts/wanlong-state-machine.md`, `examples/wanlong-config.example.json`, `examples/wanlong-state.example.json` |
| GitHub 發布與驗證 | GitHub 結構、README、Actions、PR/Issue、公開安全檢查、來源註記 | `docs/github-publishing-checklist.md`, `docs/github-upload-guide.md`, `docs/github-actions-ci.md`, `docs/source-attribution-policy.md` |

## 已學來源追查

`sources/learned-thread-traceability.json` 從 `sources/category-3-topic-coverage.md` 自動匯出，目的不是重新學內容，而是讓已學內容可被檢查：

- 已學唯一 Thread ID：177
- 專題文件數：19
- 文件內 ID 宣稱數與解析數：全部對上
- 同一 Thread ID 可出現在多個專題，這代表它被多個能力分類引用，不是重複學習錯誤

## Deep-Read 批次分類

| 批次 | 數量 | 狀態 | 主要輸出 |
|---|---:|---|---|
| source-00 | 11 | 已完成 | `docs/category-3-source-00-deep-read.md`, `sources/deep-reads/category3-*.md` |
| c3-01 | 20 | 已完成 | `docs/category-3-c3-01-deep-read.md`, `sources/deep-reads/category3-*.md` |
| c3-02 | 20 | 已完成 | `docs/category-3-c3-02-deep-read.md`, `sources/deep-reads/category3-*.md` |
| c3-03 | 20 | 已完成 | `docs/category-3-c3-03-deep-read.md`, `sources/deep-reads/category3-*.md` |
| c3-04 | 20 | 未完成 | 只建立斷點與恢復流程，不能算已學 |

## 用途導向整理

| 你要做的事 | 優先查這些分類 |
|---|---|
| 寫自動精靈 JS 腳本 | JS/API 速查、動作表達式與 DSL、流程控制與變數 |
| 做遊戲畫面判斷 | OCR / 找圖 / 視覺識別、環境與穩定性、萬龍覺醒腳本應用 |
| 做 UI 表單或彈窗 | UI / Markdown / Dialog、流程控制與變數 |
| 做資料保存或日誌 | 檔案、日誌、資料保存、JS/API 速查 |
| 接後端或授權系統 | 後端與部署、GitHub 發布與驗證 |
| 把資料放 GitHub | GitHub 發布與驗證、來源註記、安全規則 |
| 用 AI 幫忙寫腳本 | AI 輔助寫腳本、Prompt、萬龍覺醒腳本應用 |

## 後續工作規則

1. 先把已學的 177 篇維持在這份分類總表與各專題筆記中，不再倒回去補日期。
2. 剩下 132 篇只有在能讀到正文時才繼續學；如果使用者要求跳過 2024 以後文章，才先抓 `created_at` 做精準排除。
3. 新學到一批時，要更新本文件、`sources/category-3-topic-coverage.md`、`sources/deep-read-ledger.md` 與狀態輸出。
4. 沒讀正文或影片的，不得標記為已學。
