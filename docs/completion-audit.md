# 完成度稽核

更新日期：2026-06-19 Asia/Taipei

這份文件把使用者的原始要求拆成可檢查項目。它的目的不是宣稱完成，而是避免把「已整理一部分」誤說成「全部學完」。

## 原始要求拆解

| 要求 | 目前證據 | 判定 |
|---|---|---|
| 學習分類 3 软件使用教程 | `sources/category-3-full-manifest.md` 有 309 篇 manifest；`sources/category-3-topic-coverage.md` 顯示 177 篇已進專題、來源摘要層 0、132 篇待專題化；`docs/learned-tutorial-classification.md` 已整理已學分類 | 未完成，索引、source-00、c3-01、c3-02 與 c3-03 深讀已完成，已學內容已分類，仍有 132 篇待專題化 |
| 分類 4 软件使用交流 | 2026-06-18 使用者要求停止後續學習 | 已從完成條件移除，既有文件只保留歷史參考 |
| 任何教學、教程都不能漏 | `docs/tutorial-map.md`、`sources/study-queue.generated.md`、`sources/learned-thread-traceability.json`、`tools/build-study-queue.ps1` 用於追蹤隊列與已學來源 | 未完成，177 篇已學可追查，仍有 132 篇未專題化 |
| 每篇文章要有可檢查學習痕跡 | `docs/deep-read-protocol.md`、`templates/deep-read-note.md`、`templates/batch-review-report.md`、`sources/deep-read-ledger.md`、`tools/verify-deep-read-records.ps1` | 規則與檢查工具已建立，source-00、c3-01、c3-02 與 c3-03 已有 71 份正式 deep-read |
| 代碼、API、表達式都要學 | `docs/zdjl-api-cheatsheet.md`、`docs/action-expression-dsl-notes.md`、`docs/js-api-notes.md` | 部分完成，仍需從剩餘文章補來源 |
| 架設、後端、熱更新、卡密要理解 | `docs/backend-deployment-notes.md`、`examples/update-manifest.example.json`、`examples/backend-api-contract.example.json`、`prompts/backend-security-review.md` | 部分完成，安全版已整理，後續只從分類 3 補強 |
| 可以放進 GitHub | `.gitignore`、`.github/workflows/verify-learning-library.yml`、`.github/PULL_REQUEST_TEMPLATE.md`、`.github/ISSUE_TEMPLATE/`、`CONTRIBUTING.md`、`SECURITY.md`、`docs/source-attribution-policy.md`、`docs/github-actions-ci.md`、`docs/github-publishing-checklist.md`、`docs/github-upload-guide.md`、`START_HERE.md`、`README.md`、`sources/learning-status.generated.json`、`sources/learned-tutorial-classification.json`、`sources/learned-thread-traceability.json`、`sources/study-queue.full.generated.md`、`sources/study-queue.full.generated.json`、`tools/export-learned-traceability.ps1`、`tools/export-learning-status.ps1`、`tools/export-study-queue.ps1`、`tools/verify-learning-library.ps1`、`tools/verify-deep-read-records.ps1`、`tools/verify-github-package.ps1`、`tools/verify-source-attribution.ps1` | 第一版可整理成 GitHub 倉庫，但不能宣稱全量完成 |
| 要理解架構 | `docs/architecture.md`、`docs/tutorial-learning-roadmap.md`、`docs/learning-library-index.md` | 已有第一版架構整理，仍會隨深讀補強 |

## 目前最硬的缺口

- 分類 3：132 篇尚未專題化，來源摘要層已歸零。
- 分類 4：已依使用者要求停止，不再列入完成條件。
- 每篇 deep-read note 已開始建立；source-00、c3-01、c3-02 與 c3-03 有 71 份正式紀錄。
- 已學 177 個唯一 Thread ID 已建立追查索引；已學內容不用再補日期，只做分類、去重、摘要與用途整理。
- 先前 Node/Chrome 式請求已讀完 source-00、c3-01、c3-02 與 c3-03；2026-06-19 續讀 c3-04 時 Codex 可用路徑出現 504/連線問題。

## 驗證方式

本地完整檢查：

```powershell
.\tools\verify-learning-library.ps1
```

包含外部論壇探測：

```powershell
.\tools\verify-learning-library.ps1 -CheckForum
```

注意：論壇不可用時，`-CheckForum` 會失敗；這代表外部來源不可讀，不代表本地筆記格式壞掉。

## 最新驗證結果

2026-06-19 Asia/Taipei：

| 檢查 | 結果 | 說明 |
|---|---|---|
| `tools/verify-learning-library.ps1` | 通過 | 必要檔案、PowerShell 語法、Markdown fence、範例 JSON、分類 3 覆蓋表、深讀隊列、`.gitignore` 都通過 |
| `tools/export-learned-traceability.ps1` | 通過 | 已產生 `sources/learned-thread-traceability.json`，177 個唯一已學 Thread ID 可追查到 19 份專題文件 |
| `tools/export-learning-status.ps1` | 通過 | 已產生 `sources/learning-status.generated.json`，記錄分類 3/4 數字、deep-read 批次、GitHub readiness 與未完成原因 |
| `tools/export-study-queue.ps1` | 通過 | 已產生 `sources/study-queue.full.generated.md/json`，目前只記錄分類 3 的 132 篇待補項 |
| `tools/verify-deep-read-records.ps1` | 通過 | 已有 source-00、c3-01、c3-02 與 c3-03 的 71 份正式 deep-read 紀錄 |
| `tools/verify-source-attribution.ps1` | 通過但有警告 | 來源 URL、來源範圍、deep-read 模板與公開整理政策通過；警告只用於提醒後續批次仍需逐篇補齊 |
| `tools/verify-github-package.ps1` | 通過但有警告 | GitHub 必備文件、PR/Issue 模板、忽略規則、公開檔案大小、附件類型與疑似 secret 格式通過；只提醒 `tmp/` 有本地測試輸出 |
| `tools/verify-learning-library.ps1 -CheckForum` | 未通過 | 失敗點只有 `forum-probe`；分類頁、分類 API、單篇頁與單篇 API 都回報連線接收錯誤 |
| 敏感詞掃描 | 需人工複核 | 命中項目目前是安全提醒與「不要公開密鑰/token/卡密」規則，不是已確認的真實密鑰 |

## 不能宣稱完成的條件

只要以下任一項仍存在，就不能說完整完成：

- `sources/category-3-topic-coverage.md` 的尚未專題化不為 0。
- `sources/category-3-continuation-plan.md` 還有未完成批次。
- 分類 4 已停止，不再作為完成缺口。
- 敏感內容沒有經過人工確認。
- PowerShell 探測不能單獨代表分類 3 不可讀；但後續批次仍必須取得正文、回覆、附件/影片線索後才能標成已學。
