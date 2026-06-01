// Generated from PHABizPush.xml
// Source export timestamp: 2026-04-29 16:59:43

/// 人工重推前端 Facade
/// Author: Valen MPF
Class PHA.COM.BaseBizPush.Manual.Facade.PushManualFacade Extends %RegisteredObject
{
/// 前端查询可用推送目标
/// 入参最小化：entryCode + 当前上下文(hospId,deptCode)
/// w ##class(PHA.COM.BaseBizPush.Manual.Facade.PushManualFacade).QueryTargets("OP_DISPEN","2","182")
ClassMethod QueryTargets(entryCode As %String, hospId As %String, deptCode As %String) As %DynamicObject
{
    set resp = ##class(PHA.COM.BaseBizPush.Manual.Query.PushTargetQueryService).Query(entryCode, hospId, deptCode)
	quit resp.ToDynamicObject()
	
    set targets = []
    if $isobject(resp.Targets) {
        for i=1:1:resp.Targets.Count() {
            set item = resp.Targets.GetAt(i)
            do targets.%Push({
                "keyword": (item.Keyword),
                "targetClass": (item.TargetClass),
                "displayName": (item.DisplayName)
            })
        }
    }

    set keywords = []
    if $isobject(resp.Keywords) {
        for j=1:1:resp.Keywords.Count() {
            do keywords.%Push(resp.Keywords.GetAt(j))
        }
    }

    quit {
        "success": (resp.Success),
        "message": (resp.Message),
        "total": (resp.Total),
        "keywords": (keywords),
        "targets": (targets)
    }
}

/// 前端执行选中目标
ClassMethod Execute(req As PHA.COM.BaseBizPush.Manual.DTO.PushExecuteRequestDTO) As %DynamicObject
{
    set resp = ##class(PHA.COM.BaseBizPush.Manual.Execute.PushManualExecuteService).Execute(req)
	quit resp.ToDynamicObject()
	
    set items = []
    if $isobject(resp.Items) {
        for i=1:1:resp.Items.Count() {
            set item = resp.Items.GetAt(i)
            do items.%Push({
                "keyword": (item.Keyword),
                "targetClass": (item.TargetClass),
                "success": (item.Success),
                "message": (item.Message)
            })
        }
    }

    quit {
        "success": (resp.Success),
        "message": (resp.Message),
        "successCount": (resp.SuccessCount),
        "failureCount": (resp.FailureCount),
        "results": (items)
    }
}

/// 前端执行选中目标（动态对象入参，内部反序列化）
ClassMethod ExecuteByDynamic(reqDyn As %DynamicObject) As %DynamicObject
{
    set req = ##class(PHA.COM.BaseBizPush.Manual.DTO.PushExecuteRequestDTO).FromDynamicObject(reqDyn)
    quit ..Execute(req)
}
}
