# 分类 4 部分扫描记录

来源：<https://bbs.zdjl.site/#/thread/category/4>

分类 4 是「软件使用交流」，约 7596 篇。这个分类里大量内容是问答型教学，不能只看标题有没有“教程”两个字。

> 更新：已找到论坛 API 并完成分类 4 索引级全量抓取。分类 4 目前只保留建立于 2024-01-01 后的内容；新的正式范围记录见 `sources/category-4-api-scan.md`。本文件保留为网页滚动阶段的历史记录与第一批候选样本。

## 当前扫描状态

- 已抓取标题索引：1783 篇
- 抓取排序：最新回复
- 抓取范围：从 2026-06-14 附近一路到 2025-03-10 附近
- 关键词候选：1265 篇
- 强教学/实作候选：858 篇
- 已打开正文的第一批代表文章：14 篇
- 已打开楼层式正文的第二批代表文章：24 篇，其中 5 篇需要复查
- 网页滚动阶段未完成：2025-03-10 之前的更旧交流帖当时还无法从页面继续补抓；后续已由 API 补齐索引。

## 重要限制

本分类页面当时没有可直接使用的关键字搜索框，`page / p / offset / skip` 等 URL 参数也没有改变列表结果。前端滚动在 1783 篇左右停止继续载入，所以本文件只代表“网页阶段已抓到的区段”，不是最终范围。

## 关键词策略

候选关键词包含：

- 教程、教学、教我、求教、如何、怎么、请问、求助
- 代码、源码、JS、表达式、函数、正则、字符串
- 变量、UI、界面、弹窗、按钮
- OCR、识别、文字、数字、图片、找图、找色、颜色、OpenCV
- 坐标、点击、滑动、手势、多条件、条件、跳转、动作
- 循环、重复、定时、时间、等待
- 文件、日志、WPS、URL、API、联网、本地、保存、读取
- 权限、悬浮窗、无障碍、Root、异常、暂停、停止、黑屏、鸿蒙
- 卡密、热更新、验证、后端、服务器、防检测

## 主題候選樣本

### JS / 代码 / 表达式

- [25445 JS 找图/寻图返坐标](https://bbs.zdjl.site/#/thread/detail/25445)
- [25363 JS 找颜色相似度](https://bbs.zdjl.site/#/thread/detail/25363)
- [25345 JS 变量文字识别](https://bbs.zdjl.site/#/thread/detail/25345)
- [25295 文件不存在时返回当前时间](https://bbs.zdjl.site/#/thread/detail/25295)
- [25070 运行 JS 代码调用已有动作](https://bbs.zdjl.site/#/thread/detail/25070)
- [24901 JS 修改变量并记住新值](https://bbs.zdjl.site/#/thread/detail/24901)

### OCR / 识别 / 找图 / 找色

- [25539 多数字识别后比较大小](https://bbs.zdjl.site/#/thread/detail/25539)
- [25496 OpenCV 模板匹配坐标](https://bbs.zdjl.site/#/thread/detail/25496)
- [25445 JS 找图/寻图返坐标](https://bbs.zdjl.site/#/thread/detail/25445)
- [22870 OCR 滑块验证码](https://bbs.zdjl.site/#/thread/detail/22870)
- [23556 免费本地 OCR OcrServer](https://bbs.zdjl.site/#/thread/detail/23556)
- [25280 颜色识别从下往上识别](https://bbs.zdjl.site/#/thread/detail/25280)

### 动作 / 条件 / 坐标 / 跳转

- [25276 多条件点击写法](https://bbs.zdjl.site/#/thread/detail/25276)
- [25522 微调坐标点击位置](https://bbs.zdjl.site/#/thread/detail/25522)
- [25519 找图出现后延时点击](https://bbs.zdjl.site/#/thread/detail/25519)
- [25374 跳转动作怎么用](https://bbs.zdjl.site/#/thread/detail/25374)
- [25420 第二次出现动作时跳转](https://bbs.zdjl.site/#/thread/detail/25420)

### 文件 / 日志 / API

- [10561 日志输出到 txt 文件](https://bbs.zdjl.site/#/thread/detail/10561)
- [25373 取图保存到手机并转码](https://bbs.zdjl.site/#/thread/detail/25373)
- [25295 读取文件不存在时返回当前时间](https://bbs.zdjl.site/#/thread/detail/25295)
- [23246 JS 创建文件夹或文件](https://bbs.zdjl.site/#/thread/detail/23246)
- [22936 按 txt 文件文字顺序点击文字](https://bbs.zdjl.site/#/thread/detail/22936)

### 权限 / 运行异常 / 稳定性

- [25524 识别黑屏怎么办](https://bbs.zdjl.site/#/thread/detail/25524)
- [25479 鸿蒙 6.0 可用性](https://bbs.zdjl.site/#/thread/detail/25479)
- [25116 运行时无法暂停](https://bbs.zdjl.site/#/thread/detail/25116)
- [25303 长时间运行稳定性](https://bbs.zdjl.site/#/thread/detail/25303)
- [24388 模拟器 OCR 调用出错](https://bbs.zdjl.site/#/thread/detail/24388)

## 待补

- 已用 API 绕过滚动停止问题，补齐索引并套用 `created_at >= 2024-01-01` 范围。
- 继续对 API 筛出的高价值候选分批打开正文和回覆楼层。
- 把有答案、有代码、有架构价值的问答合并到 `docs/` 的专题笔记。

## 已讀批次

- 第一批代表文章：记录在 `docs/category-4-first-pass-notes.md` 的“已打开代表文章”。
- 第二批楼层式文章：记录在 `docs/category-4-first-pass-notes.md` 的“第二批已打开问答”。

## 第二批待复查

- [23251 如何给脚本加入卡密验证](https://bbs.zdjl.site/#/thread/detail/23251)
- [25496 OpenCV 图片模板匹配坐标](https://bbs.zdjl.site/#/thread/detail/25496)
- [25053 识别屏幕数字并比较大小](https://bbs.zdjl.site/#/thread/detail/25053)
- [23842 变量获取图片坐标卡死](https://bbs.zdjl.site/#/thread/detail/23842)
- [25522 微调坐标点击位置](https://bbs.zdjl.site/#/thread/detail/25522)
