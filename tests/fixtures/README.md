# 虛擬測試截圖資料夾規格

這個資料夾用來放萬龍覺醒採集腳本的測試截圖與標註資料。公開 GitHub 時建議只放可公開截圖或裁切後資料；含帳號、聯盟、私人資訊的圖片要先打碼。

## 建議命名

```text
001_city_home.png
002_world_map_idle.png
003_search_gold_dialog.png
004_resource_found_panel.png
005_resource_not_found_text.png
006_gather_button_missing.png
007_create_troop.png
008_marching.png
009_troop_full.png
010_role_manager.png
```

## 每張圖要有標註

可用同名 JSON 保存期望狀態：

```json
{
  "image": "004_resource_found_panel.png",
  "expectedState": "OPEN_RESOURCE_PANEL",
  "requiredSignals": ["resource_panel", "resource_level"],
  "forbiddenActions": ["act_march"],
  "nextAction": "check_gather_button",
  "notes": "有資源面板，但仍需確認採集按鈕存在。"
}
```

## 必備場景

| 場景 | 為什麼要測 |
|---|---|
| 主城 | 確認能切到世界地圖 |
| 世界地圖空閒 | 搜尋入口與回復入口 |
| 資源搜尋彈窗 | 資源類型與等級選擇 |
| 找到資源 | 可開資源面板 |
| 找不到資源文字 | 不應盲點，應降級或換資源 |
| 有資源但無採集按鈕 | 不應建立隊伍或行軍 |
| 建立部隊畫面 | 檢查隊伍可用與兵力 |
| 行軍中 | 狀態轉移到等待或下一隊 |
| 採集中 | 不重複派同一隊 |
| 隊伍滿 | 切下一角色或等待 |
| 角色管理 | 切號流程 |
| 載入畫面 | 等待，不做危險點擊 |

## 測試規則

- 每張圖只對應一個主要狀態。
- 一張圖可有多個識別信號，但不能讓腳本靠單一固定坐標硬猜。
- 失敗圖比成功圖更重要，尤其是找不到資源、採集按鈕不存在、隊伍滿。
- 測試資料不要包含真實密鑰、私人接口、後端地址或未授權源碼。
