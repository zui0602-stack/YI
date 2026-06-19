# 動作、表達式與 DSL 專題筆記

本文件整理自自動精靈教程區與 2024 後交流區中，和「查看動作表達式、JS 調用動作、腳本動作變量、函數封裝、子腳本參數、動態生成動作、ZEasyAction / UI DSL」相關的內容。目標是把積木和 JS 之間的接口整理清楚，之後修改萬龍覺醒腳本時可以穩定拆小段、測小段、再組成大流程。

## 已讀來源

| 主題 | Thread ID | 分類 | 連結 |
|---|---:|---|---|
| 查看動作表達式、源碼、JS 函數裡運行動作 | 19076 | 教程 | <https://bbs.zdjl.site/#/thread/detail/19076> |
| ZEasyAction 純代碼構建動作庫 | 18458 | 教程 | <https://bbs.zdjl.site/#/thread/detail/18458> |
| 動態生成動作、動態更新腳本 | 17850 | 教程 | <https://bbs.zdjl.site/#/thread/detail/17850> |
| 動作複製器 | 17895 | 教程 | <https://bbs.zdjl.site/#/thread/detail/17895> |
| runMultiAction 簡化腳本開發 | 10602 | 教程 | <https://bbs.zdjl.site/#/thread/detail/10602> |
| 變量「腳本動作」用途 | 14968 | 教程 | <https://bbs.zdjl.site/#/thread/detail/14968> |
| 函數封裝及調用 | 18245 | 教程 | <https://bbs.zdjl.site/#/thread/detail/18245> |
| 子腳本傳入參數與接收參數 | 14798 | 教程 | <https://bbs.zdjl.site/#/thread/detail/14798> |
| 異步動作與同時運行多動作 | 11362 | 教程 | <https://bbs.zdjl.site/#/thread/detail/11362> |
| 變量封裝、AI 拆流程與 JS 調用 | 25429 | 教程 | <https://bbs.zdjl.site/#/thread/detail/25429> |
| JS 調用已編輯動作 | 25070 | 交流 | <https://bbs.zdjl.site/#/thread/detail/25070> |
| 動態生成彈窗問題 | 20349 | 交流 | <https://bbs.zdjl.site/#/thread/detail/20349> |
| 彈窗提示與 setVar | 22175 | 交流 | <https://bbs.zdjl.site/#/thread/detail/22175> |
| ZEasyUI 純代碼寫界面 | 18050 | 教程 | <https://bbs.zdjl.site/#/thread/detail/18050> |
| Kodex 運行時 DSL UI 引擎 | 22075 | 教程 | <https://bbs.zdjl.site/#/thread/detail/22075> |
| Kodex 教程 | 22076 | 教程 | <https://bbs.zdjl.site/#/thread/detail/22076> |
| Markdown 表格玩法 | 21920 | 教程 | <https://bbs.zdjl.site/#/thread/detail/21920> |
| Markdown 表格崩潰問答 | 21799 | 交流 | <https://bbs.zdjl.site/#/thread/detail/21799> |

## 核心結論

自動精靈的大型腳本最好拆成兩層：

- 積木層：負責真正點擊、滑動、OCR、找圖、找色、彈窗、設定變量等可視化動作。
- 調度層：用 JS、腳本動作變量、函數、子腳本、動作組來決定何時執行、失敗怎麼恢復、下一步走哪裡。

教程裡最重要的能力是：先用 UI 做出一個能跑通的小動作，再查看動作表達式或源碼，把它變成可以被 JS 或變量重複調用的結構。這比一開始就憑空寫一大段代碼穩定很多。

## 動作表達式與動作 JSON

### 1. 動作表達式的用途

查看動作表達式不是為了手改所有 JSON，而是為了理解每個積木實際保存了什麼：

- `type`：動作類型，例如點擊、滑動、設置變量、屏幕識別。
- `posData`：坐標、百分比坐標或識別結果。
- `condition`：運行條件。
- `delay` / `duration`：等待與按下時間。
- `vars`：設定變量動作內的 UI 或變量配置。
- 腳本回調或監聽配置：成功、失敗、結束後的處理。

整理原則：

- 修改大型腳本前，先看源碼確認真實欄位，不只看動作顯示名稱。
- 同一類動作如果只有坐標、文字、圖片不同，適合抽成模板。
- 動作 JSON 內的百分比坐標比固定像素更適合跨分辨率。
- 來源動作要保持小而單純，方便單獨測試。

### 2. JS 運行動作

教程展示的核心 API 是 `zdjl.runAction` 和 `zdjl.runActionAsync`。整理後可分成兩種用途：

| 類型 | 用途 | 萬龍例子 |
|---|---|---|
| 同步運行 | 很快完成、只做一次的小動作 | 設定狀態、短提示、簡單點擊 |
| 異步運行 | 需要等待動作完成後再判斷 | 點搜尋、等待 OCR、開採集面板 |

範例方向：

```js
// 原創示意：只保留模式，不搬原帖完整代碼。
async function runNamedAction(actionJson, label) {
  if (!actionJson) {
    console.log(label + ': action is empty');
    return false;
  }

  try {
    await zdjl.runActionAsync(actionJson);
    return true;
  } catch (err) {
    console.log(label + ': run failed ' + err);
    return false;
  }
}
```

使用規則：

- JS 調用前先確認動作 JSON 存在。
- 有 `Async` 的調用必須 `await`，否則後續判斷可能太早執行。
- 執行失敗要回傳布爾值或錯誤碼，不要只印日誌。
- 需要後續積木讀取的結果，必須寫回自動精靈變量。

### 3. 條件檢查

新版教程提到可用 `zdjl.check` / `zdjl.checkAsync` 類方式檢查運行條件。這讓「動作是否該跑」可以獨立測試，而不是等整個流程失敗才知道條件寫錯。

建議模式：

```js
async function canRun(conditionExp, label) {
  if (!conditionExp) return true;
  try {
    return await zdjl.checkAsync(conditionExp);
  } catch (err) {
    console.log(label + ': condition check failed ' + err);
    return false;
  }
}
```

萬龍應用：

- 找資源前檢查是否在世界地圖。
- 點採集前檢查資源面板是否存在。
- 派隊前檢查可用隊伍數是否大於 0。
- 切角色前檢查目前不在戰鬥或重要彈窗中。

## 腳本動作變量

### 1. 單個腳本動作

「腳本動作」變量適合存一個已驗證的小動作，再由多個地方調用。例如：

- `act_open_search`
- `act_back_city`
- `act_close_popup`
- `act_click_gather`

優點：

- 同一個動作只維護一份。
- UI 做好的動作能被 JS 或多動作列表重複調用。
- AI 審核時只需要知道變量名和作用，不需要重看所有坐標。

風險：

- 變量內的跳轉不一定等同於外層列表跳轉。
- 動作執行完後會回到引用它的流程位置，容易造成「重跑後又接著跑原流程」。
- 因此腳本動作變量適合做單一步驟，不適合把整條長流程都塞進去。

### 2. 腳本動作陣列

「數組(腳本動作)」適合存多個同類動作，例如不同資源類型的點擊、不同角色的登入入口、不同彈窗關閉方式。

設計規則：

- 陣列內每個元素功能相同，只是參數不同。
- 調用前檢查索引合法。
- 每個元素都有獨立成功判斷。
- 陣列不要同時混入「點擊」「OCR」「回城」等不同職責。

萬龍例子：

| 陣列 | 內容 |
|---|---|
| `resource_select_actions` | 金礦、伐木場、鐵礦、魔水的選擇動作 |
| `role_login_actions` | 每個角色在角色管理列表中的選擇方式 |
| `popup_close_actions` | 常見活動、更新、提示彈窗的關閉動作 |

## 函數封裝

函數封裝教程雖然是 JS 基礎，但在自動精靈裡很重要。每個函數最好只做一件事，且輸入輸出明確。

推薦函數形狀：

```js
async function stepSearchResource(resourceType, level) {
  // 回傳 { ok, reason } 比只回 true/false 更容易排錯。
  const result = { ok: false, reason: '' };

  // 這裡調用已驗證的動作變量或 action JSON。
  // 每一步都要有判空、日誌和失敗原因。

  return result;
}
```

命名規則：

- `act_`：已封裝的單一步驟動作。
- `step_`：狀態機中的一步。
- `task_`：多個 step 組成的任務。
- `check_`：只判斷，不操作。
- `recover_`：失敗回復入口。

## runMultiAction 與批量動作

runMultiAction 教程的價值不是照抄函數，而是學到「動作序列 + 重試 + 錯誤收集」這個模式。

整理成通用原則：

- 動作序列應該是資料，而不是散落在各處的複製貼上。
- 每一步有名稱、執行函數、最多重試次數和失敗原因。
- 重試後仍失敗，要回傳出錯步驟清單。
- 日誌要印出第幾步、步驟名稱和錯誤。

原創示意：

```js
async function runSteps(steps) {
  for (let i = 0; i < steps.length; i++) {
    const step = steps[i];
    const ok = await step.run();
    if (!ok) {
      return { ok: false, failedAt: i, name: step.name };
    }
  }
  return { ok: true };
}
```

萬龍可用於：

- 回城校準序列。
- 搜尋資源序列。
- 派隊建立序列。
- 切角色登入序列。

## 異步與同時運行多動作

異步動作教程提醒：不是所有動作都真正適合同時跑。多動作同時運行適合以下場景：

- 長按某個位置，同時監測中斷條件。
- 多指手勢。
- PC 按鍵組合。
- 低頻監控和主流程短時間重疊。

不建議：

- 同時高頻 OCR。
- 同時多個全屏找圖。
- 同時多個會改同一變量的流程。
- 同時點擊互相重疊的區域。

萬龍腳本中，異步更適合「等待中斷」而不是「並行識別」。例如行軍過程中每隔一段時間檢查是否回到安全畫面，而不是同時跑多個 OCR。

## 子腳本參數

子腳本傳參教程的重點是：新版可以把參數傳給子腳本，避免所有資料都塞到全局變量。

整理規則：

- 只把子腳本真正需要的資料傳進去。
- 子腳本回傳或輸出要明確，不要偷偷改大量全局變量。
- 多角色、多資源、多帳號流程可以用參數化子腳本降低重複。
- 但大型遊戲流程若過度拆子腳本，排錯會變難；要保留清楚日誌。

萬龍例子：

```text
run subscript gather_role
  args:
    roleName
    resourceType
    minLevel
    maxSearchTimes
```

## 動態生成動作與動態更新腳本

動態生成動作、動態更新腳本的教程展示了高階玩法，但交流回覆也提醒：隱藏 API 不保證長期穩定。GitHub 學習庫應只整理架構，不依賴隱藏接口。

安全規則：

- 優先使用正式 `readFile` / `writeFile` 類 API。
- 不把隱藏 API 當正式能力寫進萬龍主流程。
- 動態更新前要有版本號、備份、回滾與校驗。
- 遠端返回的腳本不能直接執行，至少要做來源、版本與格式檢查。
- 公開 GitHub 不放私人更新地址、token、卡密算法。

適合學的架構：

- `.zjs` 本質是可被讀取、組裝與保存的腳本資料。
- 遠端編輯器或工具可以批量產生動作。
- 動作複製器適合把已驗證模組搬到新腳本。

不建議直接公開：

- 付費附件完整源碼。
- 私人後端地址。
- 可遠程執行任意代碼的完整實作。

## ZEasyAction 與動作 DSL

ZEasyAction 的方向是用純代碼構建自動精靈動作。它適合有 JS 基礎、需要大量模板化動作的人。

可學架構：

- 用類或工廠函數產生動作物件。
- 用 props 描述每個動作的可變部分。
- 用變量模式讓 UI 和動作互通。
- 用依賴 props 避免重複設定。
- 用友好錯誤提示降低排錯成本。

落地到萬龍時，不建議一開始就把整個腳本改成 DSL。比較穩的順序是：

1. 先用自動精靈 UI 做可跑通動作。
2. 將 3 到 5 個重複動作抽成模板。
3. 只對重複度最高的地方使用 DSL。
4. 每個 DSL 產物都輸出動作 JSON 供人工檢查。
5. 保留最小可回退版本，避免 DSL 本身出錯時整個腳本不能跑。

## UI DSL、Kodex 與 Markdown 表格

UI DSL 相關教程包括 ZEasyUI、Kodex、Markdown 表格。它們說明自動精靈 UI 可以從簡單變量彈窗進一步變成可配置界面。

整理結論：

- ZEasyUI 適合用代碼批量建立原生變量 UI。
- Kodex 適合更複雜的聲明式界面，但抽象較重。
- Markdown 表格適合展示列表、狀態、報告。
- 不同平台和版本對 Markdown 表格、圖片、事件支持可能不同。
- 大型 UI 要先做最小 demo，確認不閃退、不卡住、不吃太多性能。

動態彈窗注意：

- 臨時生成的彈窗每次可能被視為新彈窗。
- `dialogShowOnce` 類參數不一定能阻止每輪重複顯示。
- 穩定做法是自己存 `hasShownDialog` 旗標。
- 彈窗 JS 內的局部變量不會自動給後續動作用，要用 `zdjl.setVar` 類方式寫回。

萬龍 UI 建議：

- 基本配置用原生變量 UI。
- 偵錯狀態可用簡易 Markdown 提示。
- 角色列表、資源隊列若要表格化，先做小量資料測試。
- 正式採集流程不要依賴複雜 UI 渲染成功才能繼續。

## AI 與動作封裝工作流

AI 拆流程教程的價值在於：不用讓 AI 從零猜坐標，而是把已驗證動作交給 AI 排流程。

推薦流程：

1. 人工在自動精靈中建立小動作。
2. 將小動作命名成 `act_` 或 `check_`。
3. 查看動作表達式，確認動作內容。
4. 把變量名、用途、成功條件整理給 AI。
5. 讓 AI 產生狀態機或調度 JS。
6. 用虛擬截圖和假資料測試流程。
7. 實機測試後再回填失敗案例。

給 AI 的資料應該像這樣：

```text
已存在動作:
- act_open_search: 打開搜尋面板，成功條件是看見「搜尋」按鈕。
- act_select_gold: 選擇金礦。
- check_gather_button: 檢查資源面板是否出現「採集」按鈕。
- recover_back_world: 關閉彈窗並回世界地圖。

請只寫調度流程，不要猜測坐標。
```

## 萬龍覺醒採集腳本映射

### 1. 建議動作清單

| 動作名 | 職責 | 成功條件 |
|---|---|---|
| `act_go_world` | 切到世界地圖 | 地圖搜尋按鈕存在 |
| `act_open_search` | 打開資源搜尋 | 搜尋彈窗存在 |
| `act_select_resource` | 選資源類型與等級 | 當前資源高亮 |
| `act_click_search` | 執行搜尋 | 畫面跳轉或提示文字出現 |
| `check_resource_found` | 判斷是否找到資源 | 資源點面板或資源模型存在 |
| `act_open_resource_panel` | 點資源點 | 資源資訊面板出現 |
| `check_gather_button` | 判斷採集按鈕是否存在 | OCR/找圖找到採集 |
| `act_create_troop` | 建立或選擇隊伍 | 出現行軍按鈕 |
| `act_march` | 派隊行軍 | 右側隊伍狀態變行軍 |
| `recover_no_resource` | 找不到資源時恢復 | 回到搜尋入口或切資源等級 |

### 2. 狀態機調度

```text
SEARCH_RESOURCE
  -> resource found: OPEN_RESOURCE_PANEL
  -> not found text: LOWER_LEVEL_OR_NEXT_TYPE
  -> timeout: RECOVER_WORLD

OPEN_RESOURCE_PANEL
  -> gather button exists: CREATE_TROOP
  -> gather button missing: RECOVER_WORLD
  -> occupied / invalid: SEARCH_RESOURCE

CREATE_TROOP
  -> troop available: MARCH
  -> no troop: NEXT_ROLE
  -> timeout: RECOVER_WORLD
```

### 3. 虛擬測試重點

這份筆記可直接轉成虛擬測試案例：

- `runActionAsync` 是否有等待完成。
- 動作變量不存在時是否停止並記錄。
- 找不到資源文字出現時是否走 `recover_no_resource`。
- 採集按鈕不存在時是否不會盲點行軍。
- 彈窗重複出現時是否有 `hasShownDialog` 控制。
- 多角色參數是否沒有污染全局狀態。

## 代碼審核清單

| 項目 | 必查問題 |
|---|---|
| 動作 JSON | 是否有 `type`、坐標、條件、延遲等必要資料 |
| 異步 | `runActionAsync` / `checkAsync` 是否 `await` |
| 作用域 | JS 局部結果是否用 `setVar` 寫回 |
| 空值 | 動作變量、坐標、OCR、節點是否判空 |
| 跳轉 | 腳本動作變量內外跳轉是否會造成重複執行 |
| 重試 | 每個 step 是否有最大重試或超時 |
| 日誌 | 是否能看出失敗在哪個動作 |
| 隱藏 API | 是否依賴不穩定內部接口 |
| 依賴 | UI DSL 或 CDN 是否有降級方案 |
| 安全 | 是否包含私人地址、token、完整付費源碼 |

## GitHub 收錄規則

- 保留來源 ID 和連結。
- 不複製 ZEasyAction、ZEasyUI、Kodex 或附件的完整源碼。
- 公開文件只寫架構、模式、風險、原創示意碼。
- 付費腳本、商業附件只記錄「學到的架構」。
- 隱藏 API 只記錄風險，不作為推薦方案。
- 萬龍實作中使用的坐標、截圖、配置要和教學筆記分開保存。
