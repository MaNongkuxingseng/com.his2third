# ObjectScript 导入说明

## 导入范围

本仓库保存的是从 `PHABizPush.xml` 提取出的 `.cls` 类源码。导入 IRIS/Caché 时，应以 `PHA/` 下的类文件为准。

## 建议流程

1. 在目标环境确认命名空间，例如 `DHC-APP`。
2. 备份目标环境中同名类或确认已有版本。
3. 使用 IRIS Studio、VS Code ObjectScript 扩展或 Atelier API 导入 `.cls` 文件。
4. 优先导入框架层 `PHA.COM.BaseBizPush`，再导入业务层 `PHA.FACE.TPS.SA.HIS2SA`。
5. 在目标命名空间执行编译，记录编译错误和警告。
6. 使用业务测试方法或人工重推入口做最小验证。

## 导入顺序建议

```text
PHA.COM.BaseBizPush.DTO
PHA.COM.BaseBizPush.Engine.Context
PHA.COM.BaseBizPush.Engine.Definition
PHA.COM.BaseBizPush.Engine.Filter
PHA.COM.BaseBizPush.Engine.Platform
PHA.COM.BaseBizPush.Engine.Result
PHA.COM.BaseBizPush.Engine.Target
PHA.COM.BaseBizPush.Engine.Template
PHA.COM.BaseBizPush.Business
PHA.COM.BaseBizPush.App
PHA.COM.BaseBizPush.Manual
PHA.FACE.TPS.SA.HIS2SA.DTO
PHA.FACE.TPS.SA.HIS2SA.Data
PHA.FACE.TPS.SA.HIS2SA.Platforms
PHA.FACE.TPS.SA.HIS2SA.Target
PHA.FACE.TPS.SA.HIS2SA.BusinessEntry
```

## 注意事项

- 中文注释和字符串应保持 UTF-8，不要在未确认编码的情况下批量转码。
- DTO 属性变更可能影响 `Storage Default`，需要在 IRIS 中重新确认存储定义。
- 外部平台类如 `web.DHCENS.STBLL.SOAP.PUB0005Soap` 不在本仓库内，导入前需确认目标环境存在。
- 当前文档不替代 IRIS 编译结果；最终可用性以目标环境编译和业务验证为准。
