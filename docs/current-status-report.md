# 目前進度總覽

更新時間：2026-06-18 24:30 Asia/Taipei

這份報告是給人工檢查用的短版戰情表。完整證據仍以 `sources/learning-status.generated.json`、`sources/study-queue.full.generated.json`、`docs/completion-audit.md` 與驗證工具輸出為準。

## 目前結論

第一版 GitHub 學習庫已整理成可公開檢查的形狀，但尚未達成「所有教程都已完整深讀」。

不能宣稱完成的原因不是本地包缺少架構，而是分類 3 仍有 132 篇尚未專題化。先前瀏覽器式請求已讀完 source-00、c3-01、c3-02 與 c3-03；但 2026-06-19 Codex 端續讀 c3-04 時出現 504/連線問題，所以不能把剩餘批次算完成。

## 範圍規則

| 範圍 | 規則 | 狀態 |
|---|---|---|
| 分類 3 軟件使用教程 | 全部教程，不做日期排除 | 已建立 309 篇完整清單與覆蓋表 |
| 分類 4 軟件使用交流 | 2026-06-18 使用者要求停止 | 只保留歷史參考，不再學習 |
| 教學/教程內容 | 代碼、API、架設、後端、OCR、UI、流程、影片教學都算 | 已分成專題筆記與待深讀隊列 |
| GitHub 公開版 | 只能放公開安全摘要、架構筆記、範例、模板、驗證工具 | 已建立第一版發布包 |

## 數字狀態

| 項目 | 數字 | 意義 |
|---|---:|---|
| 分類 3 manifest | 309 | 教程分類總清單 |
| 分類 3 coverage total | 309 | 覆蓋表已對齊總清單 |
| 分類 3 missing/extra/duplicate | 0 / 0 / 0 | 目前沒有漏列、誤列、重複列 |
| 分類 3 已專題化 | 177 | 已經寫入專題筆記 |
| 分類 3 來源摘要層 | 0 | source-00 已補完成 |
| 分類 3 尚未專題化 | 132 | 已列入後續深讀批次 |
| 分類 4 API 掃描總數 | 7596 | 來源 API 掃到的總筆數 |
| 分類 4 實際分類 4 | 7593 | 排除非分類 4 項後 |
| 分類 4 2024 後有效 | 3535 | 符合使用者最新規則的保留範圍 |
| 分類 4 2024 前排除 | 4058 | 依規則不納入深讀 |
| 分類 4 高價值候選 | 暫停 | 不再列入後續學習 |
| 分類 4 代表性 Q&A | 歷史參考 | 既有筆記保留但不再擴充 |

## 已經整理的學習主題

- 自動精靈整體架構與腳本組織方式。
- JS/API 基礎、變量、storage、剪貼板、網路請求、文件讀寫。
- 流程 UI、變量設計、條件跳轉、監聽、循環與錯誤處理。
- OCR、找圖、找色、坐標、截圖與視覺辨識策略。
- UI、Markdown、對話框、表單與可視化配置。
- Node/App 自動化、控件查找、文字/描述/children 選擇。
- 環境問題、模擬器、Root、權限、OCR ERROR、穩定性排查。
- 後端、架設、熱更新、卡密、API contract 與安全公開版整理。
- AI 輔助生成腳本、prompt 約束、代碼審核與安全收錄規則。
- 萬龍覺醒腳本的虛擬測試流程、截圖規格、狀態機 prompt 與範例狀態。

## GitHub 準備狀態

| 項目 | 狀態 |
|---|---|
| README / START_HERE | 已有 |
| CONTRIBUTING / SECURITY | 已有 |
| GitHub Actions | 已有 |
| PR 模板 | 已有 |
| Issue 模板 | 已有 |
| 來源歸因政策 | 已有 |
| GitHub 上傳指南 | 已有 |
| 發布檢查清單 | 已有 |
| 機器可讀進度 JSON | 已有 |
| 完整待深讀隊列 | 已有 |
| 發布包驗證工具 | 已有 |

## 最新驗證

| 檢查 | 最新結果 |
|---|---|
| `tools/verify-learning-library.ps1` | 通過，failure 0 |
| `tools/verify-github-package.ps1` | 通過，failure 0 |
| `tools/verify-category3-coverage.ps1` | 通過，missing/extra/duplicate 都是 0 |
| `tools/verify-source-attribution.ps1` | 通過，逐篇 deep-read 紀錄已建立 |
| `tools/verify-deep-read-records.ps1` | 通過，source-00 與 c3-01 已有正式 deep-read 紀錄 |
| `sources/learned-tutorial-classification.json` | 已建立，可給 AI/工具讀取已學分類 |
| `sources/learned-thread-traceability.json` | 已建立，177 個已學 Thread ID 都可追查到專題文件 |

## 論壇狀態

2026-06-18 曾用瀏覽器式請求成功讀取分類 3 API、source-00、c3-01、c3-02 與 c3-03 文章正文。2026-06-19 續讀 c3-04 時，Codex 可用路徑出現 504/連線問題；這只影響後續新讀取，不影響已完成的分類與筆記。

因此目前不能做兩件事：

- 不能宣稱分類 3 全部 309 篇已逐篇深讀完成，因為仍有 132 篇待專題化。
- 不能只用 PowerShell 連線失敗判定整站不可讀；但 c3-04 必須等可讀來源恢復後才能標成已學。

## 下一步施工順序

1. 等論壇或可用瀏覽器路徑恢復後，從 c3-04 續讀分類 3 API 與文章正文。
2. 不再處理分類 4。
3. 用 `tools/build-study-queue.ps1` 重建待深讀清單。
4. 從 `sources/study-queue.full.generated.md` 的 `c3-04` 開始逐篇建立 deep-read note。
5. 每讀完一批，回填 `sources/category-3-topic-coverage.md`。
6. 重新跑全部驗證，確認 GitHub 公開版沒有原文搬運、完整源碼、密鑰、卡密算法、繞過或濫用流程。

## 目前判定

狀態：可上傳 GitHub 的第一版已具備；完整學習目標仍在進行中。

## 2026-06-19 已學內容分類整理

- 已經學好的教程不再回頭補日期；日期只用於未學文章是否要跳過的判斷。
- 已學內容已整理到 `docs/learned-tutorial-classification.md`，這是目前最適合人工檢查的總表。
- 機器可讀分類在 `sources/learned-tutorial-classification.json`，方便之後放進 GitHub 或給 AI 學習庫使用。
- 已學 Thread ID 追查在 `sources/learned-thread-traceability.json`，目前唯一 Thread ID 是 177 個，對應 19 份專題文件。
- 目前不把 c3-04 算成已學；它只保留斷點與恢復流程，避免把沒有完整讀過的內容混進學習庫。

## 2026-06-19 c3-04 Access Attempt

- Active scope is Category 3 only; Category 4 remains paused.
- The next batch is c3-04: 17723, 20880, 19820, 547, 18034, 7819, 20593, 16774, 13280, 19666, 21083, 17676, 17694, 11207, 20884, 996, 14729, 860, 4673, 17258.
- Codex-accessible routes currently returned 504/connection errors, so c3-04 is still pending and must not be counted as learned.
- Evidence and resume steps are in `sources/category-3-c3-04-access-log.md`.

## 2026-06-19 Category 3 Remaining Date Check

- The 132 pending Category 3 threads are not proven to be all 2024-or-newer.
- The saved queue currently has thread IDs but not complete `created_at` values for every pending thread.
- A quick ID-position check found 97 pending IDs below 16000 and 35 IDs at or above 16000, so the remaining queue is mixed and should not be bulk-skipped.
- If the active rule is changed to skip 2024-or-newer Category 3 threads, first fetch each pending thread's real `created_at`, then exclude only proven matches.
