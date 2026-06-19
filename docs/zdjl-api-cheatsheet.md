# 自動精靈 JS/API 速查表

本文件把已讀官方 JS 文檔、分類 3 教程與先前已讀分類 4 歷史交流問答整理成 GitHub 可公開的 API 速查筆記。它不是完整官方手冊；未在已讀來源中反覆確認的參數，不在這裡硬寫死。

主要來源：

- [1380 自動精靈「運行 JS 代碼」文檔](https://bbs.zdjl.site/#/thread/detail/1380)
- [11749 zdjl.findNode 正則查找節點](https://bbs.zdjl.site/#/thread/detail/11749)
- [19076 查看動作表達式與 JS 調動作](https://bbs.zdjl.site/#/thread/detail/19076)
- [21863 運行 JS 代碼獲得圖片坐標](https://bbs.zdjl.site/#/thread/detail/21863)
- [19813 節點 text 複製到剪貼板](https://bbs.zdjl.site/#/thread/detail/19813)
- [18662 本地存儲 API 存變量](https://bbs.zdjl.site/#/thread/detail/18662)
- [20009 requestUrl 用法問題](https://bbs.zdjl.site/#/thread/detail/20009)
- [25352 AI prompt 強約束](https://bbs.zdjl.site/#/thread/detail/25352)

## 使用規則

- 優先用自動精靈界面建立一個可跑通動作，再查看動作表達式或變量表達式。
- JS 只封裝已驗證過的動作，不憑空猜 API 參數。
- 普通 App 優先節點；遊戲自繪畫面優先 OCR、找圖、找色與坐標校準。
- 任何 OCR、節點、找圖、坐標結果都要判空。
- 要給後續動作用的 JS 結果，必須顯式寫回自動精靈變量。
- 網路、文件、OCR、找圖都要有失敗返回，不讓主流程卡住。

## API 分類速查

| 類別 | 常見 API / 能力 | 適合場景 | 主要風險 |
|---|---|---|---|
| 變量 | `zdjl.getVar`, `zdjl.setVar` | JS 與積木動作交換資料 | 局部變量未寫回 |
| 本地存儲 | `zdjl.getStorage`, `zdjl.setStorage` 類能力 | 持久化配置、今日狀態、角色索引 | 型別與版本遷移 |
| 剪貼板 | `zdjl.getClipboard`, `zdjl.setClipboard` | 讀寫文本、輸入框貼上、OCR 原始資料轉交 | 剪貼板被其他 App 覆蓋 |
| 節點 | `zdjl.findNode`, `findNodeAsync` 類能力 | 普通 App、權限彈窗、系統頁 | 節點快取、節點失效 |
| 坐標定位 | `zdjl.findLocation` | 把文字、圖片、顏色、節點條件轉成坐標 | 條件對象格式錯、坐標未定義 |
| 屏幕識別 | `zdjl.recognitionScreen` 類能力 | OCR、圖片資料、驗證碼類識別 | 高頻卡死、全屏誤識別 |
| 網路請求 | `zdjl.requestUrl`, `requestUrlAsync` 類能力 | API、遠端配置、通知、熱更新 | URL 編碼、超時、JSON 解析 |
| 動作調用 | `runAction` 類模式 | JS 調用已編輯動作、批量動作 | 動作源碼與依賴變量不一致 |
| 日誌 | `console.log`, `console.warn`, `console.error` | 偵錯、狀態輸出 | 高頻日誌拖慢 |
| 互動提示 | toast、alert、confirm、prompt、select 類能力 | 測試、人工確認、設定輸入 | 長流程中阻塞 |

## 變量讀寫

來源：`1380`, `18439`, `19879`, `18443`, `22175`

用途：

- JS 計算結果給運行條件使用。
- OCR 清洗結果給下一步判斷。
- 狀態機把目前階段寫給 UI 或日誌。

推薦模式：

```js
function setBool(name, value) {
  zdjl.setVar(name, Boolean(value), "global");
}

function setText(name, value) {
  zdjl.setVar(name, String(value ?? ""), "global");
}
```

注意：

- `let x = ...` 或 `const x = ...` 只在 JS 動作內有效。
- 運行條件要讀到結果，就寫回自動精靈變量。
- 布爾值用真正的 `true/false`，不要混用 `"true"` 字串。
- 複雜配置用 JSON 或 storage，不要散落在多個彈窗變量裡。

## 本地存儲與配置

來源：`16221`, `18662`, `23640`, `file-api-log-notes.md`

適合保存：

- 是否已初始化。
- 上次角色索引。
- 今天是否已執行。
- UI 設定後的持久配置。

建議：

- 小資料用 storage。
- 多角色、多資源、多套配置用 JSON 文件。
- 配置加版本號，方便日後升級。

萬龍建議配置：

```json
{
  "version": 1,
  "roles": ["role01", "role02"],
  "resources": ["gold", "wood", "ore"],
  "level": 5,
  "maxRetry": 5,
  "debug": true
}
```

## 剪貼板

來源：`19813`, `17463`, `25334`, `18286`

用途：

- 節點文字轉到輸入框。
- OCR 原始 JSON 暫存。
- 文件逐行讀取後貼上。

推薦模式：

```js
function copyNodeText(node) {
  const text = node?.text ?? node?.desc ?? "";
  zdjl.setClipboard(String(text));
  return text;
}
```

注意：

- 不要直接調 Android 底層剪貼板類，可能有 Looper 線程問題。
- 大量輸入時要保存當前行號。
- 剪貼板不是可靠資料庫，重要資料另存 storage 或 JSON。

## 節點查找

來源：`11749`, `1698`, `15518`, `18926`, `17906`, `node-app-automation-notes.md`

適合：

- 微信、表單、普通 App、系統權限頁。
- 有 `text`、`desc`、`idResName`、`className`、`packageName` 的控件。

不適合：

- 萬龍覺醒地圖、城內、資源點、行軍畫面。
- WebView/canvas/遊戲自繪內容。

選擇器優先順序：

1. 穩定 id。
2. 精準文字。
3. 描述文字。
4. class + text/desc。
5. package + depth + class。
6. 正則文字。
7. 父子兄弟節點關係。

安全取值：

```js
function readNodeText(node) {
  if (!node) return "";
  if (node.text) return String(node.text);
  if (node.desc) return String(node.desc);
  if (node.children && node.children.length > 0) {
    return readNodeText(node.children[0]);
  }
  return "";
}
```

注意：

- 短時間重複讀取可關閉節點快取；長時間不刷新要懷疑頁面結構變了。
- `children[0]` 前必須確認存在。
- 正則條件優先使用自動精靈界面可產生的格式，再搬進 JS。

## 找坐標與 findLocation

來源：`1380`, `21863`, `20326`, `visual-recognition-notes.md`

用途：

- 根據圖片、文字、顏色、節點取得可點擊坐標。
- 把界面動作中的識別條件搬進 JS。

最安全流程：

1. 在自動精靈界面先建立一個可跑通的坐標變量。
2. 查看變量表達式或動作表達式。
3. 把真實對象結構整理成 JS 模板。
4. JS 使用前做判空與陣列長度檢查。

通用保護：

```js
function centerOf(location) {
  if (!location) return null;
  if (Array.isArray(location) && location.length >= 2) {
    return { x: Number(location[0]), y: Number(location[1]) };
  }
  if (location.x != null && location.y != null) {
    return { x: Number(location.x), y: Number(location.y) };
  }
  return null;
}
```

萬龍注意：

- 不要用全屏找「採集」；要限制在資源面板或按鈕區。
- 找不到結果時保存截圖，不要盲點預設坐標。
- 同解析度真機與模擬器仍可能坐標不同。

## 屏幕識別與 OCR

來源：`1380`, `25439`, `16379`, `23731`, `21470`, `visual-recognition-notes.md`

用途：

- 資源等級。
- 倒計時。
- 找不到資源提示。
- 角色名或行軍狀態。

清洗數字：

```js
function toNumberFromOcr(text) {
  const raw = String(text ?? "");
  const cleaned = raw.replace(/[^\d.-]/g, "");
  if (!cleaned) return null;
  const value = Number(cleaned);
  return Number.isFinite(value) ? value : null;
}
```

穩定規則：

- 限制區域。
- 降低頻率。
- 空字串、錯誤、超時都要回傳可處理狀態。
- OCR 結果寫入變量，後續條件讀變量，不要每個條件重新 OCR。
- 模擬器 OCR ERROR 時先試兼容模式、提高內存、換識別方式。

萬龍建議：

- 資源等級、採集按鈕、行軍時間分區識別。
- 找不到資源提示只掃提示區或上方黑條。
- 倒計時能用進度條顏色就少用高頻 OCR。

## 找圖、找色與區域顏色

來源：`16545`, `15692`, `14761`, `18438`, `10679`, `24122`

找圖適合：

- 固定圖標。
- 按鈕圖案。
- 資源圖標。

找色適合：

- 按鈕亮起。
- 冷卻狀態。
- 進度條比例。
- 畫面是否卡住。

規則：

- 找圖要限制區域。
- 找色用多點多色比單點穩。
- 區域顏色通常比 OCR 更適合高頻循環。
- 目標圖受光效、縮放、陰影影響時要準備多套樣本。

## 網路請求

來源：`1275`, `4598`, `5574`, `10865`, `20009`, `20760`, `backend-deployment-notes.md`

用途：

- 遠端配置。
- 網路時間。
- 完成通知。
- 熱更新。
- 卡密/授權。
- 遠端 OCR。

通用模式：

```js
async function requestJson(config) {
  try {
    const res = await zdjl.requestUrlAsync(config);
    const body = res?.body ?? res?.data ?? res;
    return typeof body === "string" ? JSON.parse(body) : body;
  } catch (error) {
    console.error("request failed", String(error?.message ?? error));
    return null;
  }
}
```

注意：

- 中文、空格、特殊符號要 URL 編碼。
- 不把 token、key、卡密規則放 GitHub。
- 遠端失敗不應卡死主流程。
- 大型依賴或重任務放後端，手機腳本只請求結果。

## 文件與日誌

來源：`209`, `10237`, `14337`, `23246`, `24778`, `21599`, `21792`

用途：

- `config.json` 保存設定。
- `state.json` 保存當前進度。
- `logs/YYYY-MM-DD.txt` 保存摘要。
- `screenshots/error-*` 保存異常截圖。

日誌格式建議：

```text
[2026-06-15 14:03:22] [role03] [SEARCH] resource=gold level=5 found=false
```

規則：

- 追加日誌，不覆蓋歷史。
- 高頻循環不要每次寫文件。
- 錯誤、狀態切換、角色結束一定寫。
- 文件不存在時建立預設值。

## 動作調用與流程封裝

來源：`19076`, `25070`, `25429`, `flow-ui-variable-notes.md`

適合：

- 重複動作參數化。
- UI 裡已編輯的動作用 JS 批量調度。
- 多資源、多角色、多隊伍共用一套流程。

原則：

- 動作組只做一件事。
- 每個動作組有輸入、輸出、成功條件、失敗條件。
- 成功與失敗都寫狀態變量。
- JS 調動作前先確定依賴變量已存在。

萬龍動作組建議：

- `ensureWorldMap`
- `openSearchPanel`
- `selectResourceType`
- `searchResource`
- `openResourcePanel`
- `startGather`
- `checkTroopStatus`
- `recoverToKnownState`

## UI 與彈窗

來源：`25398`, `16319`, `11889`, `20349`, `22917`, `22175`, `21920`

用途：

- 腳本配置。
- 狀態面板。
- 偵錯面板。
- 多角色列表。
- 資源策略選擇。

規則：

- UI 只作為配置入口，核心狀態另存 storage 或 JSON。
- 動態彈窗可能被視為新彈窗，不能只靠一次性顯示參數。
- 彈窗內 JS 變量要寫回自動精靈變量。
- Markdown 表格在不同版本可能有限制，先小範圍測試。

## AI 生成代碼審核

來源：`25352`, `20111`, `18439`, `20326`, `ai-assisted-script-notes.md`

AI 代碼不能直接上機。每段都檢查：

- 是否混入 `document` / `window` / DOM。
- 是否使用不存在的 API。
- 是否把普通 Node.js 當自動精靈。
- 是否有未判空的坐標、節點、OCR。
- 是否只用 JS 局部變量，沒有寫回。
- 是否有高頻 OCR 或無限循環。
- 是否有 token、卡密、私有接口。

## 萬龍覺醒最小 API 組合

| 需求 | 首選能力 | 備用能力 |
|---|---|---|
| 判斷城內/野外 | 找圖、找色、區域特徵 | OCR 地圖提示 |
| 打開搜尋 | 找圖/坐標校準 | 固定比例坐標 + 狀態確認 |
| 選資源 | 找圖/找色 | 坐標校準 |
| 判斷資源等級 | OCR 限區 | 圖標附近文字 |
| 判斷採集按鈕 | OCR / 找圖 / 按鈕顏色 | 面板固定區找色 |
| 建立部隊 | OCR 兵力、行軍按鈕找圖 | 坐標 + 二次確認 |
| 行軍狀態 | 部隊管理文字/進度條 | 角色頭像狀態 |
| 權限彈窗 | 節點 | OCR / 坐標兜底 |
| 記錄失敗 | 文件、截圖、console | UI 狀態面板 |

## GitHub 收錄邊界

- 本文件只整理 API 使用模式，不搬運完整論壇代碼。
- 任何密鑰、token、卡密規則、私有後端地址都用假資料。
- 涉及驗證碼、搶購、紅包、廣告對抗的內容只保留通用節點/OCR原理。
- 未確認簽名的 API 只寫「類能力」與使用策略，不寫死參數。

## 後續待補

- 從官方 JS 文檔繼續拆出更細的 API 條目。
- 為萬龍腳本建立 `api-usage-matrix.md`，標記每個狀態用到哪些能力。
- 將速查表轉成 AI prompt 可讀版本，讓 AI 生成代碼前先讀規則。
