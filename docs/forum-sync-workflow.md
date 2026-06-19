# 論壇同步與深讀工作流

這份文件說明如何把分類 3 的教程、代碼與架設資料穩定補進學習庫。分類 4 已依 2026-06-18 使用者指令停止後續學習，只保留歷史參考。

## 原則

- 先保存原始 API 結果，再寫原創筆記。
- 先小批量驗證，再全量同步。
- 分類 3 全部納入，不做年份排除。
- 分類 4 不再加入主動學習隊列；既有分類 4 文件只作歷史參考。
- 不能因為論壇 504、空白、逾時，就把文章標記成已讀。
- 敏感內容只整理安全架構，不公開真實密鑰、卡密算法、後台地址、繞過流程或未授權完整源碼。

## 第一步：確認論壇恢復

先執行：

```powershell
.\tools\probe-zdjl-forum.ps1
```

如果失敗，停止同步，只更新 `sources/category-3-continuation-plan.md` 的論壇狀態。

## 第二步：小批量抓取分類索引

先抓每個分類 1 頁確認格式：

```powershell
.\tools\sync-zdjl-forum.ps1 -CategoryIds 3 -MaxPages 1 -OutputDir sources/raw-smoke
```

預期輸出：

- `sources/raw-smoke/categories/category-3/page-0000.json`
- `sources/raw-smoke/sync-summary.json`

小批量成功後，再跑全量。

注意：`sources/raw/` 和 `sources/raw-*` 已被 `.gitignore` 排除。這些原始資料只用於本地驗證，不應直接放到公開 GitHub。

## 第三步：全量同步索引

```powershell
.\tools\sync-zdjl-forum.ps1 -CategoryIds 3 -OutputDir sources/raw
```

同步結果只代表索引已保存，不代表文章已深讀。

分類 3 的完成狀態仍以這些文件為準：

- `sources/category-3-full-manifest.md`
- `sources/category-3-topic-coverage.md`
- `sources/category-3-continuation-plan.md`

分類 4 的歷史參考狀態仍以這些文件為準：

- `sources/category-4-api-scan.md`
- `docs/category-4-first-pass-notes.md`
- `docs/category-4-deep-dive-2024.md`

## 第四步：抓指定文章詳情與回覆

`source-00` 已於 2026-06-18 完成。後續處理分類 3 時，從 `c3-01` 開始：

```powershell
.\tools\sync-zdjl-forum.ps1 -CategoryIds 3 -MaxPages 1 -FetchThreadDetails -FetchPosts -ThreadIds 2781,20249,13542,10125,9535,10229,17949,15069,11313,23956,171,284,9370,2469,21271,17689,10015,811,13580,23062 -OutputDir sources/raw
```

分類 4 不再安排新深讀。

## 第五步：產生深讀隊列

同步 raw JSON 後，先產生深讀隊列：

```powershell
.\tools\build-study-queue.ps1 -RawDir sources/raw -OutputPath sources/study-queue.generated.md
```

論壇仍不可用、沒有 raw JSON 時，也可以先用現有分類 3 覆蓋表產生待補摘要：

```powershell
.\tools\build-study-queue.ps1 -RawDir sources/raw -OutputPath sources/study-queue.generated.md
```

`sources/study-queue.generated.md` 是工作清單，不是完成證明。

為單篇文章建立 deep-read 記錄：

```powershell
.\tools\new-deep-read-note.ps1 -CategoryId 3 -ThreadId 2781 -Title "optional title"
```

## 第六步：轉成專題筆記

每篇文章至少記錄：

- Thread ID
- 標題
- 來源連結
- 主題分類
- 是否有代碼、圖片、影片、附件
- 問題模式
- 可公開的解法摘要
- 限制與風險
- 對萬龍腳本是否有用

可歸入的專題：

- `docs/zdjl-api-cheatsheet.md`
- `docs/action-expression-dsl-notes.md`
- `docs/flow-ui-variable-notes.md`
- `docs/condition-jump-listener-notes.md`
- `docs/visual-recognition-notes.md`
- `docs/file-api-log-notes.md`
- `docs/environment-stability-notes.md`
- `docs/node-app-automation-notes.md`
- `docs/ui-markdown-dialog-notes.md`
- `docs/backend-deployment-notes.md`
- `docs/ai-assisted-script-notes.md`

如果既有專題放不下，才新增新的 `docs/*.md`。

## 第七步：更新覆蓋表

分類 3 每補完一批後，必須更新：

- `sources/category-3-topic-coverage.md`
- `sources/category-3-continuation-plan.md`
- `docs/tutorial-map.md`
- `docs/progress-dashboard.md`
- `sources/study-queue.generated.md`

然後執行：

```powershell
.\tools\verify-category3-coverage.ps1
```

驗證要看到：

```text
missing_count = 0
extra_count = 0
duplicate_count = 0
```

但這只表示 ID 覆蓋表沒有錯，不代表所有文章都已專題化；專題化完成要看「尚未專題化」是否歸零。

## 第八步：GitHub 發布前檢查

執行：

```powershell
rg "API key|token|cookie|密鑰|密钥|卡密算法|管理地址|私有接口" README.md START_HERE.md docs sources prompts examples tests tools
```

命中項目必須逐條判斷：

- 如果只是安全提醒，可以保留。
- 如果是真實密鑰、私有接口、管理地址或完整敏感流程，必須移除或脫敏。

## 深讀完成定義

一篇文章只有符合以下條件，才算學進庫裡：

1. 已成功打開正文或 API 詳情。
2. 已確認不是 504、空白或錯誤頁。
3. 已看過回覆樓層，尤其是作者補充、修正與失效提醒。
4. 已整理成原創摘要。
5. 已放進至少一個專題文件或明確排除。
6. 已回填來源 ID 與連結。
7. 已通過敏感內容檢查。
## c3 Batch Browser Fetch Resume

Use this when the forum API is reachable again and the active queue is a known Category 3 batch. It avoids the category listing step and fetches only the chosen batch details and replies.

```powershell
node .\tools\sync-zdjl-forum-browser-fetch.mjs --skip-categories --c3-batch c3-04 --fetch-thread-details --fetch-posts --timeout-ms 25000 --retries 2 --retry-delay-ms 1500 --page-limit 100 --output-dir sources/raw-browser-c3-04
```

Useful flags:

- `--c3-batch c3-04`: use the built-in c3-04 thread ID list.
- `--skip-categories`: do not re-fetch the category index before thread details.
- `--timeout-ms 25000`: abort a slow request instead of hanging indefinitely.
- `--retries 2 --retry-delay-ms 1500`: retry transient 504 or connection failures.
- `--fetch-thread-details --fetch-posts`: fetch both the main post and reply pages.

Do not mark the batch as learned from the sync summary alone. The raw JSON must still be reviewed and converted into per-thread deep-read notes.
