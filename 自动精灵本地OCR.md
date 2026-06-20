# 自动精灵 OCR SDK 文档

> 用于对接 OcrServer HTTP 服务

## 基本信息

| 项目 | 内容 |
|------|------|
| OCR插件作者 | 菲佣 |
| 优化 | 陈俊呈 |
| httpserver作者 | 墨兮 |
| 版本 | 1.0.0 |
| 更新时间 | 2024-12-17 |

>已获得原作者授权  
<img src="../assets/番外/1.自动精灵本地OCR/授权.png" alt="授权" style="max-width:360px;width:100%;height:auto;" />

> 免责声明,本插件仅用于学习交流,请勿用于商业用途,否则后果自负



## 快速开始

### 1.下载插件 并 导入 SDK 

插件下载链接:  
纯净版(去掉了调试界面,更加简洁):<a href="https://lz.qaiu.top/parser?url=https://mx2534.lanzouv.com/iqTFH3dyt5ni" target="_blank">https://lz.qaiu.top/parser?url=https://mx2534.lanzouv.com/iqTFH3dyt5ni</a>  
调试版(保留了调试界面,方便调试):<a href="https://lz.qaiu.top/parser?url=https://mx2534.lanzouv.com/iq6CV3dyt3ve" target="_blank">https://lz.qaiu.top/parser?url=https://mx2534.lanzouv.com/iq6CV3dyt3ve</a>  



将 <a href="../assets/番外/1.自动精灵本地OCR/ocr-sdk.js" target="_blank">ocr-sdk.js</a> 添加进脚本开头

![导入SDK](../assets/番外/1.自动精灵本地OCR/导入SDK.png)
### 2. 配置参数

打开 `动作`,修改顶部配置：

```javascript
const host = '127.0.0.1';  // OCR服务地址
const port = 9527;         // OCR服务端口
const type = 'high';       // 精度: high(高精度) / low(低精度)
```

### 3. 使用 SDK

```javascript
// 获取 ocr 对象
const ocr = zdjl.getVar('ocr');

// 定义识别区域（通过自动精灵界面设置）
const 识别区域 = zdjl.getVar("我的识别区域");

// 执行OCR识别
const result = ocr.ocr(识别区域);
```

## API 文档

### ocr(area, options)

OCR 识别，返回所有识别结果。

**参数：**

| 参数 | 类型 | 必填 | 说明 |
|------|------|------|------|
| area | 屏幕区域 \| string | 是 | 屏幕区域对象或 Base64 字符串 |
| options | object | 否 | 可选参数 |

**options 参数：**

| 参数 | 类型 | 说明 |
|------|------|------|
| whitelist | string | 白名单字符，只识别指定字符 |
| type | string | 精度：`high` 或 `low` |
| boxes | string | 识别范围 |
| color | string | 偏色 |

**返回值：**

```javascript
{
  data: [
    {
      text: "识别的文字",
      point: { x: 100, y: 200 },  // 文字中心坐标
      box: []                      // 文字边界框
    }
  ],
  timeout: 123  // 识别耗时(ms)
}
```

**示例：**

```javascript
// 基础识别
var result = ocr.ocr(识别区域);

// 只识别数字
var result = ocr.ocr(识别区域, { whitelist: "0123456789" });

// 使用低精度模式
var result = ocr.ocr(识别区域, { type: "low" });
```

---

### hasText(area, text, options)

判断是否出现指定文字。

**参数：**

| 参数 | 类型 | 必填 | 说明 |
|------|------|------|------|
| area | 屏幕区域 \| string | 是 | 屏幕区域对象或 Base64 字符串 |
| text | string | 是 | 要查找的文字 |
| options | object | 否 | 可选参数（同 ocr 方法） |

**返回值：** `boolean`

**示例：**

```javascript
if (ocr.hasText(识别区域, "确定")) {
  zdjl.log("找到了确定按钮");
}
```

---

### clickText(area, text, options)

点击指定文字。

**参数：**

| 参数 | 类型 | 必填 | 说明 |
|------|------|------|------|
| area | 屏幕区域 \| string | 是 | 屏幕区域对象或 Base64 字符串 |
| text | string | 是 | 要点击的文字 |
| options | object | 否 | 可选参数（同 ocr 方法） |

**返回值：** `boolean` - 是否点击成功

**示例：**

```javascript
if (ocr.clickText(识别区域, "确定")) {
  zdjl.log("点击成功");
} else {
  zdjl.log("未找到文字");
}
```

---

### findText(area, text, options)

查找文字位置（精确到子字符串）。

**参数：**

| 参数 | 类型 | 必填 | 说明 |
|------|------|------|------|
| area | 屏幕区域 \| string | 是 | 屏幕区域对象或 Base64 字符串 |
| text | string | 是 | 要查找的文字 |
| options | object | 否 | 可选参数（同 ocr 方法） |

**返回值：** `{x: number, y: number} | null`

**示例：**

```javascript
let point = ocr.findText(识别区域, "开始");
if (point) {
  console.log("位置: " + point.x + ", " + point.y);
  zdjl.click(point.x, point.y);
}
```

---

### getPoint(area, text, options)

获取文字坐标（同 findText，但未找到时返回 `{x: -1, y: -1}`）。

**参数：**

| 参数 | 类型 | 必填 | 说明 |
|------|------|------|------|
| area | 屏幕区域 \| string | 是 | 屏幕区域对象或 Base64 字符串 |
| text | string | 是 | 要查找的文字 |
| options | object | 否 | 可选参数（同 ocr 方法） |

**返回值：** `{x: number, y: number}` - 未找到返回 `{x: -1, y: -1}`

**示例：**

```javascript
let point = ocr.getPoint(识别区域, "确定");
if (point.x > 0) {
  zdjl.click(point.x, point.y);
} else {
  console.log("未找到文字");
}
```

---

### getPoints(area, text, options)

获取所有匹配文字的坐标数组。

**参数：**

| 参数 | 类型 | 必填 | 说明 |
|------|------|------|------|
| area | 屏幕区域 \| string | 是 | 屏幕区域对象或 Base64 字符串 |
| text | string | 是 | 要查找的文字 |
| options | object | 否 | 可选参数（同 ocr 方法） |

**返回值：** `Array<{x: number, y: number}>` - 坐标数组，未找到返回空数组

**示例：**

```javascript
let points = ocr.getPoints(识别区域, "选项");
console.log("找到 " + points.length + " 个匹配");

// 点击所有匹配项
for (let i = 0; i < points.length; i++) {
  zdjl.click(points[i].x, points[i].y);
  zdjl.sleep(500);
}
```

---

### ping()

检查 OCR 服务是否可用。

**返回值：** `boolean`

**示例：**

```javascript
if (ocr.ping()) {
  zdjl.log("OCR服务正常");
} else {
  zdjl.log("OCR服务未启动");
}
```

## 常见用法

### 等待文字出现并点击

```javascript
function 等待并点击(text, maxWait) {
  var 识别区域 = zdjl.getVar("我的识别区域");
  var startTime = Date.now();
  
  while (Date.now() - startTime < maxWait) {
    if (ocr.clickText(识别区域, text)) {
      return true;
    }
    zdjl.sleep(500);
  }
  return false;
}

// 等待5秒，点击"确定"
等待并点击("确定", 5000);
```

### 获取屏幕所有文字

```javascript
function 获取全部文字() {
  var 识别区域 = zdjl.getVar("我的识别区域");
  var result = ocr.ocr(识别区域);
  
  var allText = "";
  for (var i = 0; i < result.data.length; i++) {
    allText += result.data[i].text + "\n";
  }
  return allText;
}
```

### 识别数字金额

```javascript
function 识别金额() {
  var 识别区域 = zdjl.getVar("金额区域");
  var result = ocr.ocr(识别区域, { whitelist: "0123456789." });
  
  if (result.data.length > 0) {
    return parseFloat(result.data[0].text);
  }
  return 0;
}
```

## 注意事项

1. **确保 OcrServer 应用已启动**：使用前请先在手机上打开 OcrServer 应用
2. **网络权限**：自动精灵需要有网络访问权限
3. **识别区域**：建议设置尽可能小的识别区域，提高识别速度
4. **精度选择**：
   - `high`：高精度，识别准确但速度较慢
   - `low`：低精度，速度快但准确率稍低

## 常见问题

### Q: OCR 服务连接失败？

1. 检查 OcrServer 应用是否已启动
2. 检查 host 和 port 配置是否正确
3. 使用 `ocr.ping()` 测试连接

### Q: 识别速度慢？

1. 缩小识别区域
2. 使用 `type: "low"` 低精度模式
3. 使用白名单减少识别字符

### Q: 识别不准确？

1. 使用 `type: "high"` 高精度模式
2. 检查识别区域是否正确
3. 使用白名单限制识别字符
