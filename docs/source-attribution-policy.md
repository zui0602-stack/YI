# 來源歸因與公開整理政策

這份學習庫的目標是整理自動精靈教程、問答、代碼思路與架設經驗，但 GitHub 版本必須是「可公開、可追蹤、可維護」的原創整理，不是論壇搬運站。

Policy markers for automated checks:

```text
public-safety-policy
no-full-unauthorized-source
incomplete-status-required
```

## 來源範圍

- 分類 3：`https://bbs.zdjl.site/#/thread/category/3`
- 分類 3 全部 309 篇都在範圍內，不套年份排除。
- 分類 4：paused by user request on 2026-06-18。既有分類 4 筆記只保留為歷史參考，不再新增學習、不再列入完成條件。

## 每篇內容必須保留的歸因

每篇正式深讀紀錄至少要有：

- Thread ID
- 分類
- 原始 URL
- 建立時間或讀取時間
- 主題分類
- 摘要寫回到哪個 `docs/*.md`
- 安全審核狀態

來源 URL 格式：

```text
https://bbs.zdjl.site/#/thread/detail/{thread_id}
```

## 可以公開的內容

- 原創摘要。
- 問題模式、原因分析、適用限制。
- 架構圖、流程圖、狀態機。
- 脫敏後的短片段或偽代碼。
- API 使用模式、坑點、錯誤排查。
- 虛擬測試規格與假資料。

## 不公開的內容

- 論壇全文搬運。
- 未授權完整源碼。
- 付費附件、商業腳本或影片原檔。
- 真實 API key、token、cookie、密碼。
- 卡密算法、後台地址、私有接口、管理密鑰。
- 可濫用的繞過、刷量、驗證碼、風控、廣告對抗流程。

## 改寫標準

每次從論壇來源整理內容時，使用這個結構：

```text
來源 ID -> 問題模式 -> 原理 -> 推薦做法 -> 限制 -> 安全排除 -> 萬龍/腳本應用
```

如果文章包含代碼：

- 先判斷是否能公開。
- 能公開時只保留最小片段或偽代碼。
- 不能公開時只描述架構、輸入輸出、錯誤處理和安全邊界。

如果文章包含影片或附件：

- 記錄它存在。
- 記錄它教什麼。
- 不直接收入 GitHub。
- 需要授權才能重新發布原始檔。

## 完成狀態不能偷跑

以下情況不得標成已學完：

- 論壇頁面或 API 讀不到。
- 只看到標題，沒讀正文。
- 只同步 raw JSON，沒有摘要與安全審核。
- 沒寫回專題筆記。
- 沒更新 coverage、queue 或 deep-read ledger。

這也是目前 `sources/learning-status.generated.json` 保持 `completion.complete = false` 的原因。
