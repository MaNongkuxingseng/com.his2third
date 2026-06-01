// Generated from PHABizPush.xml
// Source export timestamp: 2026-04-29 16:59:43

/// 人工重推执行结果 DTO
/// Author: Valen MPF
Class PHA.COM.BaseBizPush.Manual.DTO.PushExecuteResultDTO Extends %RegisteredObject
{
/// 总体是否成功
Property Success As %Boolean;

/// 总体消息
Property Message As %String;

/// 成功数
Property SuccessCount As %Integer;

/// 失败数
Property FailureCount As %Integer;

/// 明细（一个 Target 一个结果）
Property Items As %ListOfObjects [ Collection = list ];

/// 转换为前端可用动态对象
Method ToDynamicObject() As %Library.DynamicObject
{
    set results = []
    if $isobject(..Items) {
        for i=1:1:..Items.Count() {
            set item = ..Items.GetAt(i)
            continue:'$isobject(item)
            do results.%Push(item.ToDynamicObject())
        }
    }

    quit {
        "success": (..Success),
        "message": (..Message),
        "successCount": (..SuccessCount),
        "failureCount": (..FailureCount),
        "results": (results)
    }
}
}
