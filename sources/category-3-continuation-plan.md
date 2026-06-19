# 分類 3 續讀批次與斷點計畫

來源：<https://bbs.zdjl.site/#/thread/category/3>

更新日期：2026-06-19 Asia/Taipei

本文件是 `sources/category-3-topic-coverage.md` 的續讀施工單。它不把任何文章標記為已專題化，只負責記錄斷點、批次、完成標準與論壇暫時不可讀的證據，避免後續補讀時從頭亂找。

## 目前斷點

分類 3 已完成：

- 309 / 309 篇全量 Thread ID manifest。
- 309 / 309 篇詳情頁打開稽核。
- 177 篇已進入 `docs/*.md` 專題筆記。
- 0 篇只在來源摘要層。
- 132 篇尚未專題化。

下一個實際工作是：從「尚未專題化」132 篇開始，優先處理 `c3-04`。

## 本輪論壇狀態

2026-06-15 重試結果：

| 測試目標 | 結果 |
|---|---|
| `https://bbs.zdjl.site/#/thread/detail/25309` | 瀏覽器標題為 `504 Gateway Time-out` |
| `https://bbs.zdjl.site/#/thread/category/3` | 瀏覽器標題為 `504 Gateway Time-out` |
| `https://bbs.zdjl.site/#/thread/detail/2781` | 瀏覽器標題為 `504 Gateway Time-out` |
| `https://bbs.zdjl.site/bbs/threads/list?category_id=3&page_offset=0&page_limit=1&sort=-posted_at` | API 導航逾時 |

歷史結論：這輪不能把任何新正文視為已讀。此狀態已被 2026-06-18 的瀏覽器式請求結果修正。

2026-06-16 重試結果：

| 測試目標 | 結果 |
|---|---|
| `https://bbs.zdjl.site/#/thread/category/3` | 瀏覽器讀取被論壇請求拖到逾時，後改短逾時探測 |
| `https://bbs.zdjl.site/bbs/threads/list?category_id=3&page_offset=0&page_limit=1&sort=-posted_at` | PowerShell 短逾時探測：基礎連接已關閉，接收時發生未預期的錯誤 |
| `https://bbs.zdjl.site/bbs/threads/17748` | PowerShell 短逾時探測：基礎連接已關閉，接收時發生未預期的錯誤 |
| `https://bbs.zdjl.site/#/thread/detail/17748` | PowerShell 短逾時探測：基礎連接已關閉，接收時發生未預期的錯誤 |

歷史結論：2026-06-16 仍不能把 `source-00` 或 `c3-*` 批次標記為已讀。2026-06-18 已確認這是 PowerShell 直連路徑的假失敗，分類 3 可用瀏覽器式請求續讀。

2026-06-18 修正結果：

| 測試目標 | 結果 |
|---|---|
| `https://bbs.zdjl.site/bbs/threads/list?category_id=3&page_offset=0&page_limit=5&sort=-posted_at` | Node/Chrome 式請求成功，HTTP 200，讀到分類 3 JSON |
| `source-00` 11 篇 Thread API | 成功讀到正文與回覆摘要 |

結論：PowerShell 直連仍可能失敗，但 2026-06-18 的瀏覽器式請求可讀。`source-00`、`c3-01`、`c3-02` 與 `c3-03` 已完成深讀與專題化。

2026-06-19 c3-04 續讀嘗試：

| 測試目標 | 結果 |
|---|---|
| `https://bbs.zdjl.site/bbs/threads/17723` | HTTP 504 HTML page |
| `https://bbs.zdjl.site/#/thread/category/3` | Codex in-app browser 到達 `504 Gateway Time-out` |
| PowerShell forum probe | 分類頁、分類 API、單篇頁與單篇 API 都出現接收/連線錯誤 |
| User Chrome control path | Codex Chrome extension channel unavailable，無法直接檢查使用者可見的 Chrome 分頁 |

當前結論：c3-04 仍是下一個批次，但不能標記為已學；恢復步驟記錄在 `sources/category-3-c3-04-access-log.md`。

## 完成標準

每個 Thread ID 只有在同時完成以下事項後，才可以從「待專題化」移到「已進入專題筆記」：

1. 成功打開詳情頁或 API 正文，確認不是 504、空白頁或錯誤頁。
2. 讀到標題、正文重點、代碼/圖片/影片/附件線索。
3. 判斷是否屬於敏感內容；若涉及驗證、卡密、登入、後台、刷量、繞過限制，只整理安全邊界和合法架構，不收完整可濫用步驟。
4. 寫入至少一個專題文件，例如 `docs/visual-recognition-notes.md`、`docs/file-api-log-notes.md`、`docs/environment-stability-notes.md`、`docs/node-app-automation-notes.md`、`docs/backend-deployment-notes.md`、`docs/ai-assisted-script-notes.md`、`docs/action-expression-dsl-notes.md`、`docs/ui-markdown-dialog-notes.md`。
5. 回填 `sources/category-3-topic-coverage.md` 的統計與 ID 區塊。
6. 更新 `docs/tutorial-map.md` 或相關索引，讓使用者能按主題找到它。

## 已完成批次

`source-00` 的 11 篇原本只出現在來源摘要或稽核文件，已於 2026-06-18 改用瀏覽器式請求補讀正文與回覆摘要，並寫入正式專題筆記。`c3-01` 的 20 篇已同日補成批次深讀與逐篇 deep-read note。`c3-02` 與 `c3-03` 各 20 篇已於 2026-06-19 補成批次深讀與逐篇 deep-read note。

| 批次 | Thread ID | 狀態 | 下一步 |
|---|---|---|---|
| source-00 | 17748, 17705, 27, 12789, 6022, 10693, 2186, 713, 138, 6871, 250 | 已完成 | 已寫入 `docs/category-3-source-00-deep-read.md` 與逐篇 deep-read note |
| c3-01 | 2781, 20249, 13542, 10125, 9535, 10229, 17949, 15069, 11313, 23956, 171, 284, 9370, 2469, 21271, 17689, 10015, 811, 13580, 23062 | 已完成 | 已寫入 `docs/category-3-c3-01-deep-read.md` 與逐篇 deep-read note |
| c3-02 | 6694, 1287, 803, 20051, 21730, 22969, 13556, 470, 3076, 10331, 14200, 13527, 822, 11274, 2082, 18661, 18712, 20795, 742, 8727 | 已完成 | 已寫入 `docs/category-3-c3-02-deep-read.md` 與逐篇 deep-read note |
| c3-03 | 9232, 19446, 8630, 1238, 22359, 498, 22166, 22406, 22269, 5903, 17276, 21876, 9408, 8689, 16169, 15515, 18185, 897, 20221, 4578 | 已完成 | 已寫入 `docs/category-3-c3-03-deep-read.md` 與逐篇 deep-read note |

## 待專題化批次

每批最多 20 篇，照 `sources/category-3-topic-coverage.md` 的 queue 順序保留。完成一批後再進下一批。

| 批次 | 數量 | Thread ID |
|---|---:|---|
| c3-04 | 20 | 17723, 20880, 19820, 547, 18034, 7819, 20593, 16774, 13280, 19666, 21083, 17676, 17694, 11207, 20884, 996, 14729, 860, 4673, 17258 |
| c3-05 | 20 | 9293, 235, 20139, 2216, 14471, 12405, 19519, 17274, 20012, 9428, 19987, 215, 14770, 19802, 6206, 14991, 19593, 959, 712, 18503 |
| c3-06 | 20 | 11433, 11833, 813, 203, 6202, 17975, 2321, 18825, 18809, 17734, 7333, 18480, 17743, 18041, 13622, 10643, 17843, 13448, 17733, 17721 |
| c3-07 | 20 | 17642, 17432, 14723, 13510, 924, 5945, 11861, 17114, 3425, 10637, 6208, 16233, 14908, 16151, 15574, 5942, 14820, 10330, 11360, 14496 |
| c3-08 | 20 | 15246, 15143, 13519, 13703, 15001, 6882, 708, 13535, 9273, 11781, 14330, 14329, 13518, 13526, 14132, 4397, 1289, 13696, 13522, 133 |
| c3-09 | 20 | 13611, 13540, 13548, 13541, 13539, 13536, 13529, 13520, 13523, 13478, 12535, 13251, 5316, 12529, 12564, 847, 7197, 9379, 1477, 2624 |
| c3-10 | 12 | 1114, 10719, 10512, 10673, 4522, 5555, 3728, 3280, 1744, 1769, 1655, 856 |

## 批次記錄格式

每完成一批，在本文件追加：

```text
批次：
完成日期：
成功讀取：
論壇錯誤：
已寫入專題：
安全排除：
coverage 更新：
後續問題：
```

## 更新順序

1. 打開本文件，取第一個未完成批次。
2. 逐篇讀取正文與附件線索。
3. 將可公開內容寫入專題筆記。
4. 更新 `sources/category-3-topic-coverage.md` 統計。
5. 更新 `docs/tutorial-map.md` 和 `docs/github-publishing-checklist.md`。
6. 重新產生 `sources/learned-thread-traceability.json`。
7. 重新驗證 309 個 ID 在覆蓋表中無遺漏、無重複。

## 本地工具

- `tools/probe-zdjl-forum.ps1`：短逾時探測分類頁、分類 API、單篇頁和單篇 API 是否恢復。
- `tools/verify-category3-coverage.ps1`：驗證分類 3 manifest 與 coverage 的 309 個 ID 是否無遺漏、無重複、無多餘。
