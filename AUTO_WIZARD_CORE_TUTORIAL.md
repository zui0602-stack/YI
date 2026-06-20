# 自動精靈核心教程總講義

這份是給人直接學的版本，不是索引表。它把目前已整理的自動精靈教程內容收斂成「架構、JS、API、UI、條件、流程、識別、日誌、後端、萬龍測試」十個部分。

重要界線：這份講義是根據目前已整理進專題筆記的教程與問答重寫而成，沒有把論壇原文或完整源碼搬進來。尚未專題化的分類 3 文章會繼續放在待補隊列，不會假裝已經變成完整教程。

## 先讀順序

1. 先讀本文件，建立整體觀念。
2. 要查 API 名稱與失敗模式，看 `docs/zdjl-api-cheatsheet.md`。
3. 要查流程、循環、變量、監聽，看 `docs/flow-ui-variable-notes.md` 與 `docs/condition-jump-listener-notes.md`。
4. 要查 UI、Markdown、彈窗，看 `docs/ui-markdown-dialog-notes.md`。
5. 要查 OCR、找圖、找色、坐標，看 `docs/visual-recognition-notes.md`。
6. 要查文件、日誌、網路、截圖保存，看 `docs/file-api-log-notes.md`。
7. 要查後端、熱更新、卡密安全版，看 `docs/backend-deployment-notes.md`。
8. 要改萬龍採集腳本，看 `virtual_test_flow.md` 與 `tests/fixtures/README.md`。

## 1. 腳本架構

自動精靈大型腳本不要寫成一串無限點擊。比較穩的架構是：

| 層級 | 做什麼 | 例子 |
|---|---|---|
| 配置層 | 使用者可調參數 | 資源種類、最低等級、角色清單、是否啟用偵錯 |
| 狀態層 | 腳本目前跑到哪 | 目前角色、目前畫面、失敗次數、最後錯誤 |
| 識別層 | 看懂畫面 | OCR、找圖、找色、節點、坐標 |
| 動作層 | 真正操作 | 點擊、滑動、輸入、返回、等待 |
| 流程層 | 決定下一步 | 條件、跳轉、循環、監聽、重試 |
| 日誌層 | 留證據 | console、狀態面板、錯誤截圖、每日記錄 |

最小主流程可以這樣理解：

```text
啟動
-> 讀取配置
-> 初始化狀態
-> 確認目前畫面
-> 執行一個小任務
-> 驗證任務結果
-> 成功就進下一步
-> 失敗就記錄、重試、恢復或停止
```

萬龍採集腳本尤其需要狀態機，因為它會遇到城內、世界地圖、搜尋面板、資源點面板、建立部隊、行軍中、採集中、找不到資源、隊伍滿等不同畫面。每個畫面都要有自己的偵測函數與失敗回路。

## 2. JS 基本寫法

自動精靈的 JS 不是拿來炫技，而是拿來把積木動作組織起來。建議先掌握這些基本型：

### 2.1 變量

```javascript
var resourceType = "ore";
var minLevel = 5;
var retryCount = 0;
var debugMode = true;
```

規則：

- 當次 JS 內才會用到的值，用普通變量。
- 後續動作要讀的值，必須寫回自動精靈變量。
- 下次啟動還要保留的值，寫入 storage 或 JSON。

### 2.2 函數

```javascript
function isEmpty(value) {
  return value === null || value === undefined || String(value).trim() === "";
}

function toNumber(value, fallback) {
  var text = String(value || "").replace(/[^0-9.]/g, "");
  var numberValue = Number(text);
  return isNaN(numberValue) ? fallback : numberValue;
}
```

函數要短，名字要像中文句子一樣能看懂用途，例如 `detectWorldMap`、`findGatherButton`、`saveErrorShot`。

### 2.3 條件

```javascript
if (retryCount >= 3) {
  console.warn("retry limit reached");
} else if (debugMode) {
  console.log("debug mode enabled");
}
```

條件要先判空，再比較。OCR 結果、找圖結果、節點結果都可能是空值。

### 2.4 陣列與物件

```javascript
var roleList = ["FaRm 01", "FaRm 02", "FaRm 03"];

var config = {
  resourceType: "ore",
  minLevel: 5,
  maxRetry: 3,
  debugMode: true
};
```

多角色、多資源、多套設定，不要散落在很多變量裡。用物件集中管理，比較容易保存、匯出、測試。

### 2.5 例外處理

```javascript
function safeRun(label, fn) {
  try {
    console.log("[start] " + label);
    var result = fn();
    console.log("[done] " + label);
    return result;
  } catch (error) {
    console.error("[error] " + label + " " + String(error && error.message ? error.message : error));
    return false;
  }
}
```

腳本出錯時不要只停住。至少要把錯誤、目前階段、角色、截圖保存下來。

## 3. 自動精靈常用 API 地圖

實際函式名稱與參數要以你安裝的自動精靈版本為準。這裡整理的是目前筆記中反覆出現的能力地圖。

| 能力 | 常見 API / 模式 | 用途 |
|---|---|---|
| 讀寫變量 | `zdjl.getVar`、`zdjl.setVar` | JS 與積木動作交換資料 |
| 持久保存 | `zdjl.getStorage`、`zdjl.setStorage` 類能力 | 保存設定、今日狀態、角色索引 |
| 節點查找 | `zdjl.findNode`、`findNodeAsync` 類能力 | 普通 App、權限彈窗、輸入框 |
| 坐標定位 | `zdjl.findLocation` | 把文字、圖片、顏色、節點條件轉成坐標 |
| 屏幕識別 | `zdjl.recognitionScreen` 類能力 | OCR、圖片識別、驗證碼類識別 |
| 網路請求 | `zdjl.requestUrl`、`requestUrlAsync` 類能力 | 遠端配置、通知、熱更新 |
| 動作調用 | `zdjl.runAction`、`zdjl.runActionAsync` 類模式 | 用 JS 執行已編輯好的動作 |
| 日誌 | `console.log`、`console.warn`、`console.error` | 偵錯與狀態輸出 |

### 3.1 變量交換範本

```javascript
function setGlobalText(name, value) {
  var text = value === null || value === undefined ? "" : String(value);
  zdjl.setVar(name, text, "global");
}

function setGlobalBool(name, value) {
  zdjl.setVar(name, Boolean(value), "global");
}

function readText(name, fallback) {
  var value = zdjl.getVar(name);
  return value === null || value === undefined || value === "" ? fallback : String(value);
}
```

使用原則：

- OCR 結果要給後續條件用，就寫回變量。
- 彈窗按鈕結果要給下一步用，也要寫回變量。
- 不要只在 JS 局部變量裡改值，否則積木條件讀不到。

### 3.2 storage / JSON 配置範本

```javascript
function defaultConfig() {
  return {
    resourceType: "ore",
    minLevel: 5,
    maxRetry: 3,
    debugMode: false
  };
}

function loadConfig() {
  var raw = zdjl.getStorage("wanlong_config");
  if (!raw) return defaultConfig();

  try {
    return typeof raw === "string" ? JSON.parse(raw) : raw;
  } catch (error) {
    console.warn("config parse failed, use default");
    return defaultConfig();
  }
}

function saveConfig(config) {
  zdjl.setStorage("wanlong_config", JSON.stringify(config));
}
```

使用原則：

- 簡單開關可以用設定變量的「記住值」。
- 多角色、多資源、複雜配置建議用 storage 或 JSON。
- 配置和狀態分開保存，避免腳本跑一半把使用者設定污染掉。

## 4. UI、配置頁與 Markdown

UI 的目標不是漂亮，是讓腳本可配置、可檢查、可恢復。

### 4.1 配置頁應該有的欄位

| 分頁 | 欄位 |
|---|---|
| 採集 | 資源種類、最低等級、搜尋次數、採集滿後是否返回 |
| 角色 | 角色清單、起始角色、是否跳過忙碌角色 |
| 識別 | OCR 模式、找圖相似度、找不到時是否保存截圖 |
| 偵錯 | 顯示目前狀態、最後 OCR 結果、最近錯誤 |
| 後端 | 版本檢查、遠端配置開關、通知開關 |

### 4.2 UI 顯示條件

顯示與隱藏不要寫複雜邏輯。先讓 JS 算出布爾值，再交給 UI。

```javascript
var debugMode = readText("debugMode", "false") === "true";
setGlobalBool("showDebugPanel", debugMode);
```

錯誤做法：

```text
UI 裡每一項都自己判斷一大串條件
```

推薦做法：

```text
JS 先算 showDebugPanel / showAdvanced / showBackend
UI 只看這些簡單布爾值
```

### 4.3 Markdown 狀態面板

Markdown 適合顯示短狀態，不適合塞大量截圖或長表格。

```text
#MD
## 萬龍採集狀態

- 角色：FaRm 07
- 階段：搜尋鐵礦
- OCR：等級 5 鐵礦
- 失敗次數：1 / 3
- 最後錯誤：找不到採集按鈕
```

規則：

- 狀態面板只顯示摘要。
- 詳細錯誤寫入日誌或文件。
- 長表格要分頁，不要一次塞 100 行。
- 不公開真實後端地址、密鑰、卡密規則。

### 4.4 彈窗與預設分支

彈窗不要讓腳本永久卡住。彈窗應該有：

| 狀況 | 處理 |
|---|---|
| 使用者按確定 | 寫回結果變量，進下一步 |
| 使用者按取消 | 寫回取消狀態，走停止或返回 |
| 超時未選 | 走預設分支 |
| 彈窗重複出現 | 用 `hasShown...` 類旗標控制 |

範本觀念：

```javascript
var shown = zdjl.getStorage("hasShownConfigDialog") || false;

if (!shown) {
  setGlobalBool("needShowConfigDialog", true);
  zdjl.setStorage("hasShownConfigDialog", true);
} else {
  setGlobalBool("needShowConfigDialog", false);
}
```

## 5. 條件、跳轉、監聽

條件是「現在能不能跑」，不是「一直等到成功」。

### 5.1 條件設計順序

```text
1. 有沒有結果
2. 結果格式對不對
3. 數字或文字是否符合條件
4. 不符合時要去哪裡
```

OCR 數字比較範本：

```javascript
function canUseResourceLevel(rawText, minLevel) {
  if (isEmpty(rawText)) return false;
  var level = toNumber(rawText, -1);
  return level >= minLevel;
}
```

### 5.2 跳轉要跳到標識

大型腳本不要依賴「往下第幾步」。應該給重要入口命名：

```text
START
LOAD_CONFIG
CHECK_SCREEN
SEARCH_RESOURCE
OPEN_RESOURCE_PANEL
CREATE_TROOP
MARCH
VERIFY_GATHERING
ERROR_RECOVERY
END
```

這樣新增或刪除中間動作時，不會把跳轉搞亂。

### 5.3 全局監聽不是完整多線程

論壇筆記裡反覆整理到：全局監聽更適合做檢查點，不要當成能任意並行的背景線程。

推薦用法：

- 每個大步驟前後檢查一次突發彈窗。
- 每輪循環檢查是否卡住。
- OCR 或找圖失敗時進恢復流程。
- 監聽結果寫回狀態變量，而不是直接亂跳。

## 6. OCR、找圖、找色與坐標

遊戲自繪畫面通常沒有可靠節點，所以萬龍這類遊戲要以視覺識別為主。

### 6.1 識別優先順序

| 方法 | 適合 | 不適合 |
|---|---|---|
| OCR | 文字、數字、提示、倒計時 | 背景很花、單字符、高頻循環 |
| 找圖 | 固定圖標、按鈕、資源圖 | 動畫變化大、縮放差異大 |
| 找色 | 按鈕顏色、進度條、狀態色 | 顏色受光影或特效影響 |
| 多點多色 | 固定 UI、穩定圖示 | 畫面旋轉或縮放 |
| 特徵匹配 | 圖片變形、全屏找目標 | 效能較重，需要更小心 |

### 6.2 OCR 數字清洗

```javascript
function cleanNumberText(text) {
  return String(text || "").replace(/,/g, "").replace(/[^0-9.]/g, "");
}

function parseOcrNumber(text, fallback) {
  var cleaned = cleanNumberText(text);
  if (cleaned === "") return fallback;
  var value = Number(cleaned);
  return isNaN(value) ? fallback : value;
}
```

### 6.3 找不到資源的處理

找不到資源不一定會跳畫面。有時只是在畫面中出現「找不到資源」類提示，並且不會自動跳到資源點，也不會出現「採集」按鈕。

因此流程要這樣分：

```text
點搜尋
-> 等待短時間
-> 偵測是否出現資源點面板
-> 若有採集按鈕：進建立部隊
-> 若出現找不到資源文字：降低等級或換資源
-> 若都沒有：保存截圖，返回搜尋面板重試
```

偵測點：

| 畫面 | 偵測方式 |
|---|---|
| 搜尋面板 | OCR「搜尋」、資源圖標、等級滑桿 |
| 找不到資源 | OCR 關鍵字、上方提示區 |
| 資源點面板 | OCR「等級」「儲存量」「採集者」 |
| 採集按鈕 | OCR「採集」、藍色按鈕找色、按鈕圖 |
| 建立部隊 | OCR「創建部隊」「行軍」 |
| 行軍中 | 隊伍卡片、倒計時、行軍線 |

## 7. 動作表達式與 JS 調動作

教程裡很重要的思路是：先用自動精靈 UI 做出一個能跑的小動作，再查看動作表達式或源碼，把它變成可重用動作。

### 7.1 動作 JSON 概念

一個動作通常包含：

| 欄位 | 意義 |
|---|---|
| type | 動作類型，例如點擊、OCR、找圖 |
| params | 坐標、區域、相似度、等待時間 |
| condition | 運行條件 |
| success | 成功後跳轉或回調 |
| failure | 失敗後跳轉或回調 |

不要一開始就手寫超大 JSON。先用 UI 做小動作，確認能跑，再抽成可重用片段。

### 7.2 JS 調用已編輯動作

概念範本：

```javascript
async function runStepAction(name, actionJson) {
  try {
    console.log("[action] " + name);
    await zdjl.runActionAsync(actionJson);
    setGlobalBool(name + "_ok", true);
    return true;
  } catch (error) {
    setGlobalBool(name + "_ok", false);
    console.error("[action failed] " + name + " " + String(error && error.message ? error.message : error));
    return false;
  }
}
```

規則：

- 動作執行前先確認依賴變量存在。
- 動作失敗要回傳布爾值。
- 不要讓 JS 呼叫一個會永久等待的動作。
- 能拆小就拆小，方便虛擬測試。

## 8. 文件、日誌、截圖與錯誤恢復

腳本能不能長時間跑，關鍵不只在點擊準不準，而是失敗時能不能留下證據。

### 8.1 建議保存三種資料

| 類型 | 保存內容 |
|---|---|
| config | 使用者設定、角色列表、資源策略 |
| state | 目前角色、目前階段、失敗次數、最後畫面 |
| log | 每日運行摘要、錯誤原因、恢復結果 |

### 8.2 日誌格式

```text
[2026-06-19 10:30:00] role=FaRm 07 stage=SEARCH_RESOURCE ok=true note=found ore level 5
[2026-06-19 10:30:20] role=FaRm 07 stage=OPEN_PANEL ok=false note=no gather button
```

### 8.3 錯誤截圖命名

```text
screenshots/error-20260619-103020-FaRm07-OPEN_PANEL.png
```

規則：

- 找不到資源時保存截圖。
- OCR 空值時保存截圖。
- 採集按鈕找不到時保存截圖。
- 隊伍滿、行軍失敗、彈窗干擾時保存截圖。

## 9. 後端、架設、熱更新與卡密安全版

這類內容可以學架構，但公開 GitHub 時要安全整理，不能放真實密鑰、管理地址、可繞過授權的細節。

### 9.1 安全版 API contract

```json
{
  "ok": true,
  "version": "1.0.0",
  "minVersion": "1.0.0",
  "message": "ready",
  "features": {
    "remoteConfig": true,
    "notice": true
  }
}
```

### 9.2 腳本端檢查流程

```text
啟動
-> 讀本地版本
-> 請求遠端版本資訊
-> 比較 minVersion
-> 若版本太舊，提示更新並停止
-> 若可用，拉取安全配置
-> 進主流程
```

### 9.3 GitHub 收錄規則

可以放：

- 架構圖
- 假資料 contract
- 錯誤碼設計
- 版本比較思路
- 安全提醒

不能放：

- 真實密鑰
- 真實後台地址
- 真實用戶資料
- 可直接繞過授權的細節
- 付費源碼完整搬運

## 10. 萬龍覺醒採集腳本狀態機

這是把教程套到你要測的萬龍採集流程。

| 狀態 | 代表畫面 | 要偵測 | 成功下一步 | 失敗處理 |
|---|---|---|---|---|
| `CITY` | 城內 | 回城按鈕、城內建築、世界按鈕 | 切到世界 | 保存畫面，重試返回 |
| `WORLD` | 世界地圖 | 放大鏡、座標、資源點 | 打開搜尋 | 若被彈窗擋住先關閉 |
| `SEARCH_PANEL` | 資源搜尋面板 | 資源 tab、等級、搜尋按鈕 | 點搜尋 | 換資源或返回 |
| `NO_RESOURCE` | 找不到資源提示 | OCR 找不到關鍵字 | 降級或換資源 | 記錄並重試 |
| `RESOURCE_PANEL` | 資源點面板 | 等級、儲存量、採集按鈕 | 點採集 | 保存截圖，返回搜尋 |
| `CREATE_TROOP` | 建立部隊 | 創建部隊、行軍按鈕、兵力 | 點行軍 | 換角色或停止 |
| `MARCHING` | 行軍中 | 倒計時、隊伍線、隊伍卡片 | 等待採集中 | 超時回隊伍管理 |
| `GATHERING` | 採集中 | 採集中狀態、進度條、倒計時 | 記錄成功 | 若中斷，走恢復 |
| `TEAM_FULL` | 隊伍已滿 | 2/5、5/5、隊伍列表 | 等待或換角色 | 記錄原因 |
| `ERROR_RECOVERY` | 任意異常 | 最近錯誤與截圖 | 回安全入口 | 超過上限停止 |

### 10.1 虛擬測試資料格式

每張截圖都要標清楚預期狀態，不要只丟圖片。

```json
{
  "image": "tests/fixtures/wanlong-world-resource-panel.png",
  "expectedState": "RESOURCE_PANEL",
  "expectedDetections": {
    "hasGatherButton": true,
    "resourceLevel": 5,
    "resourceType": "ore"
  },
  "expectedNextStep": "CREATE_TROOP"
}
```

找不到資源的截圖不好抓沒關係，可以先用人工規格補上：

```json
{
  "image": "tests/fixtures/wanlong-no-resource-placeholder.png",
  "expectedState": "NO_RESOURCE",
  "expectedDetections": {
    "hasNoResourceText": true,
    "hasGatherButton": false
  },
  "expectedNextStep": "SEARCH_PANEL_RETRY_LOWER_LEVEL"
}
```

### 10.2 萬龍最小偵測函數清單

| 函數 | 回傳 |
|---|---|
| `detectCity()` | 是否在城內 |
| `detectWorld()` | 是否在世界地圖 |
| `detectSearchPanel()` | 是否已開搜尋面板 |
| `detectNoResource()` | 是否出現找不到資源提示 |
| `detectResourcePanel()` | 是否看到資源點面板 |
| `detectGatherButton()` | 採集按鈕坐標或 false |
| `detectCreateTroop()` | 是否在建立部隊 |
| `detectMarching()` | 是否行軍中 |
| `detectGathering()` | 是否採集中 |
| `detectTeamFull()` | 是否隊伍已滿 |

每個偵測函數都要能單獨用截圖測，這樣才是虛擬遊戲架構，不必每次都進遊戲硬跑。

## 11. 實作檢查清單

改腳本前先問自己：

- 有沒有配置、狀態、日誌分開？
- OCR 結果是否先判空？
- 數字是否先清洗再比較？
- 找圖找色是否限制區域？
- 坐標是否避免硬寫死？
- 找不到資源是否有專門分支？
- 採集按鈕不存在是否會保存截圖？
- 彈窗是否有超時預設分支？
- 跳轉是否用標識？
- 每個大步驟是否有成功與失敗出口？
- 是否避免公開真實後端、密鑰、卡密規則？

## 12. 目前已整理來源指向

這份總講義主要收斂以下文件：

| 主題 | 文件 |
|---|---|
| JS/API | `docs/js-api-notes.md`、`docs/zdjl-api-cheatsheet.md` |
| 動作表達式 | `docs/action-expression-dsl-notes.md` |
| 流程與變量 | `docs/flow-ui-variable-notes.md` |
| 條件、跳轉、監聽 | `docs/condition-jump-listener-notes.md` |
| UI、Markdown、彈窗 | `docs/ui-markdown-dialog-notes.md` |
| OCR、找圖、找色 | `docs/visual-recognition-notes.md` |
| 文件、日誌、網路 | `docs/file-api-log-notes.md` |
| 環境穩定 | `docs/environment-stability-notes.md` |
| 節點與普通 App | `docs/node-app-automation-notes.md` |
| 後端與架設 | `docs/backend-deployment-notes.md` |
| 萬龍虛擬測試 | `virtual_test_flow.md`、`tests/fixtures/README.md` |

下一步補完方式：依 `sources/category-3-continuation-plan.md` 把剩餘分類 3 待專題化文章繼續補進上述主題。補完時先更新專題筆記，再同步更新本講義。
