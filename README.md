# HIS2SA 推送工程

本仓库由 `PHABizPush.xml` 提取 ObjectScript 类源码生成，用于维护 HIS 到 SA 系统的数据推送能力。

## 项目来源

- 源文件：`PHABizPush.xml`
- 导出平台：InterSystems IRIS
- 当前源码：55 个 `.cls` 类文件
- 当前分支策略：`main` 保存稳定快照，`dev` 承接后续开发与文档补充

## 目录概览

```text
PHA/
├── COM/BaseBizPush/          # 通用推送框架
└── FACE/TPS/SA/HIS2SA/       # HIS2SA 业务实现
```

核心分层：

- `PHA.COM.BaseBizPush`：推送上下文、模板、目标、平台调用、人工重推等基础能力。
- `PHA.FACE.TPS.SA.HIS2SA`：门诊、住院、草药等 HIS2SA 业务入口、数据组装、平台适配和推送目标。

## 常用入口

- `PHA.COM.BaseBizPush.Business.App.PushService`：推送服务入口。
- `PHA.COM.BaseBizPush.Manual.Facade.PushManualFacade`：人工重推门面。
- `PHA.FACE.TPS.SA.HIS2SA.BusinessEntry.*`：业务触发入口。
- `PHA.FACE.TPS.SA.HIS2SA.Target.*`：目标系统推送实现。

## 文档

- [工程结构](docs/工程结构.md)
- [开发规范](docs/开发规范.md)
- [Git流程](docs/Git流程.md)
- [ObjectScript导入说明](docs/ObjectScript导入说明.md)

## 维护约定

- 保持 `.cls` 文件按包名目录组织。
- 提交信息使用中文，说明变更目的。
- 修改业务代码前，优先确认入口、目标、平台适配和数据来源的边界。
- 本仓库不直接包含 IRIS 编译产物。
