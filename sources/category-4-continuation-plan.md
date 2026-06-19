# 分類 4 續讀計畫

來源：<https://bbs.zdjl.site/#/thread/category/4>

更新日期：2026-06-18 Asia/Taipei

停用狀態：依使用者 2026-06-18 最新指令，分類 4 不再做後續學習。本文件只保留歷史索引、既有代表問答與當時的候選統計，不能再當成主動續讀計畫。

本文件原本用來追蹤「软件使用交流」分類的後續深讀。分類 4 不是正式教程區，但曾整理過一些教學、代碼、架設、排錯、API 用法問答；這些既有筆記只作歷史參考。

## 歷史收錄規則

- 只納入 `created_at >= 2024-01-01` 的分類 4 文章。
- 回覆樓層也只吸收 `created_at >= 2024-01-01` 的內容。
- 2024 年前建立、但 2024 後被回覆頂上來的舊帖不納入。
- 涉及卡密、登入、後台、密鑰、繞過驗證、刷量或平台對抗，只整理合法架構與安全邊界。

## 已知索引狀態

| 項目 | 數量 | 來源 |
|---|---:|---|
| 分類 4 API 總文章 | 7596 | `sources/category-4-api-scan.md` |
| 實際屬於分類 4 | 7593 | `sources/category-4-api-scan.md` |
| 2024 後有效文章 | 3535 | `sources/category-4-api-scan.md` |
| 2024 前排除 | 4058 | `sources/category-4-api-scan.md` |
| 2024 後被頂上來的舊帖排除 | 195 | `sources/category-4-api-scan.md` |
| 已整理代表問答 | 145+ | `docs/category-4-first-pass-notes.md`、`docs/category-4-deep-dive-2024.md` 與各專題 |

## 待深讀主題

| 主題 | 候選數 | 優先文件 |
|---|---:|---|
| 教學 / 問答 / 求助 | 2189 | `docs/category-4-first-pass-notes.md` |
| 代碼 / JS / 表達式 / 變量 | 728 | `docs/zdjl-api-cheatsheet.md`、`docs/action-expression-dsl-notes.md` |
| OCR / 找圖 / 找色 / 坐標 / 節點 | 940 | `docs/visual-recognition-notes.md`、`docs/node-app-automation-notes.md` |
| 流程 / 條件 / 跳轉 / 循環 / 監聽 | 1422 | `docs/flow-ui-variable-notes.md`、`docs/condition-jump-listener-notes.md` |
| 文件 / 日誌 / API / 網路 | 291 | `docs/file-api-log-notes.md` |
| 後端 / 卡密 / 熱更新 / 用戶管理 | 87 | `docs/backend-deployment-notes.md` |
| 環境 / 權限 / 模擬器 / 異常 | 419 | `docs/environment-stability-notes.md` |
| 影片 / 錄屏線索 | 55 | `docs/video-tutorial-notes.md` |

補充擴大候選：

- 環境、權限、模擬器、OCR ERROR、卡死、停止不了、紅手指與穩定性：約 741 篇。
- 節點、控件、普通 App、剪貼板、輸入框、權限彈窗與彈窗監聽：約 399 篇。
- 文件/API/日誌候選：約 505 篇。
- 條件/跳轉/監聽候選：約 764 篇。

## 暫停狀態

不再抓分類 4 raw JSON、不再產生分類 4 深讀隊列、不再把分類 4 放進完成條件。若未來使用者重新恢復分類 4，必須先重新確認範圍規則。

## 深讀記錄格式

每篇分類 4 文章要整理成：

```text
Thread ID：
建立日期：
標題：
主題：
主文重點：
有效回覆：
可公開摘要：
需要排除/脫敏：
對萬龍腳本用途：
寫入文件：
```

## 歷史完成標準

以下是暫停前的完成標準，現在只作歷史參考，不是目前任務的完成條件：

1. 3535 篇有效文章都有主題候選或排除理由。
2. 高價值候選都有正文與回覆樓層深讀記錄。
3. 每個專題文件都保留來源 ID。
4. 敏感內容已脫敏。
5. `sources/study-queue.generated.md` 可以追蹤剩餘待讀項目。
