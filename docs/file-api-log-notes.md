# 文件、API、日誌與資料保存專題筆記

本文件整理自分類 3 正式教程與先前已讀分類 4 交流問答。分類 4 已於 2026-06-18 停止後續學習，既有內容只保留為歷史參考。它負責補齊腳本工程化能力：本地文件讀寫、配置保存、JSON、日誌、網路請求、上傳下載限制、截圖與圖片處理。

## 已讀來源

### 分类 3 正式教程

| 主題 | Thread ID | 連結 |
|---|---:|---|
| 讀取本地文件指定內容 | 209 | <https://bbs.zdjl.site/#/thread/detail/209> |
| 文件增刪查改 | 10237 | <https://bbs.zdjl.site/#/thread/detail/10237> |
| FormData 上傳文件 | 14337 | <https://bbs.zdjl.site/#/thread/detail/14337> |
| 腳本完成後微信通知 | 9506 | <https://bbs.zdjl.site/#/thread/detail/9506> |
| 腳本完成後 QQ 郵箱提醒 | 10865 | <https://bbs.zdjl.site/#/thread/detail/10865> |
| 獲取網路時間 | 5574 | <https://bbs.zdjl.site/#/thread/detail/5574> |
| 緩存讀寫與創建變量 | 16221 | <https://bbs.zdjl.site/#/thread/detail/16221> |
| 簡易熱更新思路 | 14309 | <https://bbs.zdjl.site/#/thread/detail/14309> |
| 跳轉鏈接 | 3468 | <https://bbs.zdjl.site/#/thread/detail/3468> |
| 題庫匹配 | 4699 | <https://bbs.zdjl.site/#/thread/detail/4699> |
| OCR 結合題庫答題 | 11163 | <https://bbs.zdjl.site/#/thread/detail/11163> |
| Image.js 使用文檔 | 18519 | <https://bbs.zdjl.site/#/thread/detail/18519> |

### 分类 4 交流問答

| 主題 | Thread ID | 連結 |
|---|---:|---|
| 新建 txt 文件 | 16907 | <https://bbs.zdjl.site/#/thread/detail/16907> |
| 導入模組與讀寫文件 | 16555 | <https://bbs.zdjl.site/#/thread/detail/16555> |
| 替換 TXT 文檔內容 | 15485 | <https://bbs.zdjl.site/#/thread/detail/15485> |
| JS 創建文件夾或文件 | 23246 | <https://bbs.zdjl.site/#/thread/detail/23246> |
| 本地文件上傳 | 17190 | <https://bbs.zdjl.site/#/thread/detail/17190> |
| 讀取 txt 指定行 | 24778 | <https://bbs.zdjl.site/#/thread/detail/24778> |
| 按順序輸入 txt 文本 | 19316 | <https://bbs.zdjl.site/#/thread/detail/19316> |
| JSON 用於鍵值對變量 | 17513 | <https://bbs.zdjl.site/#/thread/detail/17513> |
| 文件上傳到雲服務器 | 20337 | <https://bbs.zdjl.site/#/thread/detail/20337> |
| 日誌只顯示 console.log | 16982 | <https://bbs.zdjl.site/#/thread/detail/16982> |
| 日誌內容獲取限制 | 20755 | <https://bbs.zdjl.site/#/thread/detail/20755> |
| 本地存儲 API 存變量 | 18662 | <https://bbs.zdjl.site/#/thread/detail/18662> |
| 屏幕識別結果寫入文件 | 19910 | <https://bbs.zdjl.site/#/thread/detail/19910> |
| 文件不存在時返回當前時間 | 25295 | <https://bbs.zdjl.site/#/thread/detail/25295> |
| `zdjl.requestUrl` 用法問題 | 20009 | <https://bbs.zdjl.site/#/thread/detail/20009> |
| 腳本下載文件限制 | 18272 | <https://bbs.zdjl.site/#/thread/detail/18272> |
| 添加日誌記錄 | 21599 | <https://bbs.zdjl.site/#/thread/detail/21599> |
| 大文件下載內存溢出 | 20476 | <https://bbs.zdjl.site/#/thread/detail/20476> |
| 截圖保存到指定目錄 | 18664 | <https://bbs.zdjl.site/#/thread/detail/18664> |
| 文件 JS 用法與單線程限制 | 21792 | <https://bbs.zdjl.site/#/thread/detail/21792> |

## 文件讀寫

### 1. 優先明確路徑

自動精靈腳本常見路徑是手機儲存空間，例如 `/sdcard/...` 或 `/storage/emulated/0/...`。文件讀寫失敗時，先檢查：

- 路徑是否從根目錄開始。
- 目錄是否存在。
- 應用是否有儲存權限。
- 文件名是否有特殊字元或隱藏格式問題。
- 模擬器、紅手指和真機路徑是否一致。

### 2. 讀取文本後先拆分再使用

讀取 txt 後通常得到整段文字，要取得指定行就以換行符拆成陣列。注意不同系統換行可能是 `\n` 或 `\r\n`。萬龍腳本若用 txt 保存角色清單、資源順序或座標校準資料，應在讀取後先標準化換行。

推薦資料形態：

- 一行一個角色名。
- 一行一個資源策略。
- JSON 保存複雜配置。
- 日誌用追加寫入，不覆蓋。

### 3. 覆蓋寫入與追加寫入分清楚

文件寫入分兩種：

- 覆蓋寫入：適合保存目前配置、最新狀態、單一結果。
- 追加寫入：適合寫日誌、錯誤紀錄、歷史採集結果。

大型腳本不要把所有日誌都寫在一個巨大文件裡，時間久了會拖慢讀寫。建議按日期或角色分文件。

### 4. 文件不存在要有預設值

分類 4 問答中常見需求是「文件不存在時用當前時間或預設值」。穩定規則是：

- 讀取失敗或空值時不要直接進入後續比較。
- 給出預設值，例如當前時間、空陣列、預設配置。
- 第一次運行時自動建立配置文件。

## JSON 與配置保存

### 1. 簡單配置用 storage，複雜配置用 JSON

`storage` 適合保存腳本關閉後仍需要的少量資料，例如是否已初始化、今天是否已執行、上次角色索引。多層配置更適合 JSON 文件，例如：

```json
{
  "roles": ["role01", "role02"],
  "resources": ["gold", "wood"],
  "maxSearchRetry": 5,
  "debug": true
}
```

### 2. 本地存儲可以保存變量，但要注意型別

交流區提到，存文本時要確認轉成字串，存緩存時可以保存物件。整理成規則：

- 顯示用、文件用：轉成字串。
- 邏輯用：保留布爾、數值、陣列或物件。
- 跨版本配置：保存版本號，讀取時做遷移。

### 3. UI 設定不要完全依賴彈窗記住值

如果設定很多，建議用 storage 或 JSON 做配置中心。UI 只是修改配置的入口，核心流程讀配置中心，這樣才方便 GitHub 版本寫文檔、也方便未來熱更新。

## 日誌與排錯

### 1. `console.log` 是最基本的狀態輸出

交流問答提到可以顯示 console，也可以在日誌窗口用 `console` 篩選。大型腳本建議統一日誌格式：

```text
[時間] [角色] [階段] [等級] 訊息
```

例如：

```text
[2026-06-15 14:03:22] [role03] [SEARCH] gold level=5 found=false
```

### 2. 官方日誌面板內容不一定能直接讀出

有問答指出想把官方日誌面板內容直接取出，目前不一定支持。實務上應自己封裝 `log()`：同時 `console.log`、更新狀態變量、必要時追加寫入文件。

### 3. 高頻日誌會拖慢腳本

文件寫入和日誌輸出都不是免費的。長時間採集腳本建議：

- 普通循環少寫文件。
- 狀態變更時才寫日誌。
- 錯誤與恢復流程一定寫。
- 每個角色一輪結束可寫摘要。

## 網路請求與 API

### 1. 請求結果要拆 code、headers、body

網路請求回傳通常不是單純字串，而是包含狀態碼、請求頭、內容等欄位。使用時要明確讀 `body` 類內容，再做 JSON 解析或寫入文件。

### 2. URL 參數要編碼

把變量拼進 URL 時，要注意空格、中文、特殊符號。配置或通知內容最好先做 URL 編碼，避免請求失敗。

### 3. 通知 API 只適合非敏感提醒

微信提醒、郵箱提醒、網路時間都可作為 API 應用案例，但 GitHub 版不能放真實 token、喵碼、郵箱或私有接口。公開示例只保留：

- 請求方式。
- 參數位置。
- 超時與錯誤處理。
- 成功後如何更新狀態。

### 4. 上傳文件需要分清環境

分類 3 FormData 教程指出，自動精靈 JS 引擎不是瀏覽器原生 FormData 環境，需要兼容庫或手動構造 multipart 請求。分類 4 也提醒，雲服務 SDK 要選 JS/browser 版本，不要直接拿 Node.js 服務端 SDK。

## 上傳、下載與內存限制

### 1. 大文件不適合直接用腳本下載

交流區對大文件下載的結論很清楚：自動精靈沒有流式 IO，下載稍大的文件可能內存溢出；300M 這種大文件更不應放在腳本內直接拉。

建議：

- 小配置文件可以下載。
- 大資源包交給外部下載器、後端或人工部署。
- 熱更新只更新小型腳本或配置，避免整包覆蓋。

### 2. 上傳要有超時和重試策略

本地文件上傳可能因網路、文件大小、後台限制而卡住。腳本本身卡死時通常無法自救，所以要降低風險：

- 上傳前檢查文件大小。
- 只上傳必要摘要，不上傳整張大圖。
- 分離「主流程」與「上報流程」。
- 上報失敗不應阻塞採集主流程。

## 圖片、截圖與 Image.js

Image.js 文檔提供了圖像讀取、保存、裁剪、二值化等思路。對萬龍腳本而言，圖片文件可用於：

- 保存問題畫面截圖。
- 保存找不到資源時的截圖。
- 保存 OCR 失敗樣本。
- 將截圖作為虛擬測試素材。

注意：

- `show` 類顯示方法可能慢，長流程中不要頻繁使用。
- 保存圖片要控制品質與大小。
- 截圖命名應包含時間、角色、狀態。

## 對萬龍覺醒腳本的應用

建議新增這些資料文件：

| 文件 | 用途 |
|---|---|
| `config.json` | 資源種類、等級、重試次數、角色設定 |
| `roles.txt` | 多角色順序 |
| `state.json` | 上次角色、當前階段、今日執行狀態 |
| `logs/YYYY-MM-DD.txt` | 每日運行摘要 |
| `screenshots/error-*` | 失敗畫面樣本 |

建議狀態紀錄欄位：

- `role`
- `stage`
- `resourceType`
- `resourceLevel`
- `retryCount`
- `lastOcrText`
- `lastError`
- `updatedAt`

## GitHub 整理規則

- 不放真實 API key、cookie、喵碼、郵箱、私有網盤密鑰。
- 不搬運整段論壇代碼，只放脫敏模板與架構說明。
- 文件操作示例只用 `/sdcard/example.txt` 這類假路徑。
- 上傳下載示例必須提醒大小限制、超時與錯誤處理。
- 日誌格式要統一，方便未來做虛擬測試報告。

## 下一步

- 不再新增分類 4 深讀；後續只從分類 3 待專題化隊列補文件/API/日誌內容。
- 把 `virtual_test_flow.md` 補上錯誤截圖保存規則。
- 為萬龍採集腳本設計 `config/state/log` 三類資料結構。
