# 自動精靈教程學習路線

本路線把目前已整理的論壇教程、問答、代碼筆記、架設筆記轉成學習順序。它不是照文章時間讀，而是照做腳本真正會遇到的能力讀。

## 第 0 階段：先知道整體架構

目標：知道自動精靈腳本不是只會點擊，而是一套可以拆成狀態、動作、識別、配置、日誌與恢復的流程。

先讀：

- `docs/architecture.md`
- `docs/core-tutorial-notes.md`
- `docs/tutorial-map.md`

學完要會：

- 說出一個腳本的主循環、狀態變量、動作組、錯誤出口。
- 分清楚「動作流程」和「JS/API」各自負責什麼。
- 知道為什麼萬龍採集要先做虛擬測試，而不是直接盲跑。

## 第 1 階段：JS、API、變量與動作

目標：能看懂論壇教程裡的 JS、變量、動作表達式，並知道怎麼安全封裝。

先讀：

- `docs/js-api-notes.md`
- `docs/zdjl-api-cheatsheet.md`
- `docs/action-expression-dsl-notes.md`

練習：

- 建立一個變量，讀取、修改、保存，再輸出到日誌。
- 把一個常用操作拆成「動作組」，再用 JS 調用。
- 每個 API 呼叫都加上空值判斷與失敗日誌。

重點：

- 不要把所有流程寫成一大段無出口代碼。
- 任何識別結果都要先判空，再使用坐標或文字。
- 動作調用後要等待畫面穩定，再進下一步。

## 第 2 階段：流程控制、條件、跳轉、監聽

目標：能寫長時間運行的流程，不會因為找不到按鈕、畫面卡住或狀態不同就失控。

先讀：

- `docs/flow-ui-variable-notes.md`
- `docs/condition-jump-listener-notes.md`

練習：

- 做一個「等待畫面 A，超時返回主畫面」的流程。
- 做一個「找不到目標就換下一種資源」的流程。
- 做一個「監聽突發彈窗，處理完回原流程」的流程。

重點：

- 每個狀態都要有進入條件、成功條件、失敗條件。
- 監聽只處理高優先級事件，不要讓它到處跳。
- 每輪循環都要能停止，避免腳本卡死。

## 第 3 階段：OCR、找圖、找色、坐標

目標：能處理遊戲這種控件樹不可靠的畫面，靠截圖、文字、顏色和圖像判斷狀態。

先讀：

- `docs/visual-recognition-notes.md`
- `tests/fixtures/README.md`
- `virtual_test_flow.md`

練習：

- 標註一張資源搜尋畫面，寫出可辨識區域。
- 標註一張採集按鈕畫面，寫出成功/失敗判斷。
- 設計一個「找不到資源」的回退策略。

重點：

- OCR 結果要記錄原文、範圍、信心與截圖。
- 坐標要能按螢幕比例換算，不要只寫死單一解析度。
- 找圖找色前先裁切區域，避免整屏掃描拖慢腳本。

## 第 4 階段：UI、配置、彈窗與狀態面板

目標：讓腳本可以被自己或其他人穩定使用，不需要每次改代碼才能改配置。

先讀：

- `docs/ui-markdown-dialog-notes.md`
- `examples/wanlong-config.example.json`
- `examples/wanlong-state.example.json`

練習：

- 做一份資源種類、隊伍數、角色列表的配置表。
- 做一個簡單狀態面板：目前角色、資源、隊伍、錯誤次數。
- 設計彈窗預設選項，超時也能繼續流程。

重點：

- 配置和運行狀態分開保存。
- UI 不能阻塞核心流程。
- 彈窗要有取消、超時、預設值。

## 第 5 階段：文件、日誌、網路與資料保存

目標：讓腳本能留下證據，出錯時知道是畫面問題、識別問題還是流程問題。

先讀：

- `docs/file-api-log-notes.md`
- `examples/backend-api-contract.example.json`

練習：

- 寫一份錯誤日誌格式。
- 每次找不到按鈕時保存截圖路徑與狀態。
- 設計 config、state、log 三種資料的保存邊界。

重點：

- 日誌要能回答「當時在哪個畫面、找什麼、找到什麼、下一步做什麼」。
- 網路請求要有超時、重試與錯誤處理。
- 不要把真實 token、cookie、key 寫進 GitHub。

## 第 6 階段：環境、權限、模擬器與穩定性

目標：知道同一份腳本在真機、模擬器、紅手指、不同 Android 版本上可能出現什麼差異。

先讀：

- `docs/environment-stability-notes.md`
- `docs/node-app-automation-notes.md`

練習：

- 做一張設備檢查表：解析度、截圖、OCR、無障礙、停止保護。
- 做一個啟動前自檢流程。
- 做一個出錯後回主畫面的流程。

重點：

- 模擬器和雲手機的截圖、OCR、坐標可能不同。
- 無障礙和 root 模式要分開檢查。
- 停止不了腳本是高風險問題，必須有保護出口。

## 第 7 階段：後端、熱更新、授權與 GitHub 發布

目標：能把教程裡的後端、熱更新、卡密內容整理成安全架構，不把敏感細節放進公開倉庫。

先讀：

- `docs/backend-deployment-notes.md`
- `prompts/backend-security-review.md`
- `docs/github-publishing-checklist.md`

練習：

- 用 `examples/update-manifest.example.json` 設計熱更新 manifest。
- 用 `examples/backend-api-contract.example.json` 設計授權 API 回應格式。
- 跑發布前敏感內容檢查。

重點：

- GitHub 只放假資料、架構、脫敏模板。
- 不放卡密算法、管理地址、私有接口、真實密鑰。
- 熱更新要有版本、校驗、回退策略。

## 第 8 階段：套用到萬龍覺醒採集腳本

目標：把教程能力轉成萬龍採集腳本可測、可改、可回復的流程。

先讀：

- `virtual_test_flow.md`
- `prompts/wanlong-state-machine.md`
- `prompts/code-review.md`

建議順序：

1. 先整理截圖場景：城內、野外、搜尋、資源卡、採集按鈕、創建部隊、行軍、部隊管理、找不到資源。
2. 再建立狀態機：每個畫面都寫成功、失敗、超時、退回。
3. 再做最小動作：回城、出城、搜尋資源、點採集、創建部隊。
4. 再補日誌：每一步保存狀態與錯誤截圖。
5. 最後才串成完整自動採集流程。

## 每次補讀論壇文章時的規則

1. 先確認文章能正常打開，不是 504 或空白。
2. 記錄 Thread ID、標題、主題、是否有代碼、圖片、影片、附件。
3. 將內容整理成原創摘要，不整篇搬運。
4. 敏感內容只記安全邊界，不記可濫用步驟。
5. 把 Thread ID 寫回對應專題和 `sources/category-3-topic-coverage.md`。
6. 跑 `tools/verify-category3-coverage.ps1` 確認沒有漏號、重複或多餘。
