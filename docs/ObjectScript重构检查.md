# ObjectScript 重构检查

## 目标

本检查用于防止推送内核重新出现历史调用方式，尤其是平台调用绕过 `PlatformAdapter`、业务上下文重新扩散历史字段、模板基类再次承载执行编排。

## 执行方式

```powershell
powershell -ExecutionPolicy Bypass -File .\tools\Scan-ObjectScriptRefactor.ps1
```

## 当前硬性规则

- 生产代码不得出现 `target.GetInvoke()`、`Method GetInvoke()`、`PlatformInvoke`、`InvokeByMethod`、`IPlatformBindingProvider`。
- 平台调用统一由 `PlatformInvoker -> PlatformAdapter` 完成；缺省适配统一走 `DefaultPlatformAdapter`。
- `BasePushTemplate` 只保留模板入口和抽象声明，不保留 `ExecuteOne`、`ExecuteSync`、`DoInvoke` 等旧编排方法。
- 业务上下文在入口边界兼容历史字段，进入内核后统一使用 `bizInfo.data.id`、`bizInfo.data.no`、`bizInfo.ext`。
- SOAP 平台类直接调用只能出现在 `Platforms.Adapter` 或测试工具中。

## Review 关注点

- 新增 Target 时，只实现元信息、payload、响应解析、成功判断和过滤逻辑，不声明平台类和方法。
- 新增 BusinessEntry 时，平台类、方法、平台码、扩展参数必须写入 `reg.AddTarget(...)`。
- 新增平台差异时，优先新增专用 `PlatformAdapter`；只有通用一参、二参或标准 `HIPMessageInfo` 场景才依赖默认适配器。
- 修改 `bizInfo` 入参时，只在 DTO/Factory/Context 边界做历史字段兼容，业务代码不得继续读取 `phd`、`phdReturn`、`refundId`、`prescNo`、`dspId` 等顶层字段。
