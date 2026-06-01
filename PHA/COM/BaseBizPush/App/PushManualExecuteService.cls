// Generated from PHABizPush.xml
// Source export timestamp: 2026-04-29 16:59:43

/// 人工推送执行服务
/// Author: Valen MPF
Class PHA.COM.BaseBizPush.App.PushManualExecuteService Extends %RegisteredObject
{
/// 通过控制 Context，仅执行指定 TargetClass
ClassMethod ExecuteByTargets(req As PHA.COM.BaseBizPush.DTO.PushExecuteRequestDTO) As %Status
{
    s ctx = ##class(PHA.COM.BaseBizPush.Engine.Factory.ContextFactory).FromValues(req.EntryCode, req.HospId, req.DeptCode, {}, "MANUAL", req.TargetClasses)

    s entryClass = ##class(PHA.COM.BaseBizPush.Engine.Resolve.EntryResolver).Resolve(req.EntryCode)
    q:entryClass="" $$$ERROR($$$GeneralError,"Entry not found")

    s entry = ##class(PHA.COM.BaseBizPush.Engine.Factory.TargetFactory).NewEntry(entryClass)
    q entry.Execute(ctx)
}
}
