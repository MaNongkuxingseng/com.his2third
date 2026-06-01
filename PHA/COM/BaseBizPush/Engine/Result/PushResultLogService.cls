// Generated from PHABizPush.xml
// Source export timestamp: 2026-04-29 16:59:43

/// 单目标推送结果日志服务
/// Author: Valen MPF
Class PHA.COM.BaseBizPush.Engine.Result.PushResultLogService Extends %RegisteredObject
{
/// 记录单目标推送结果日志（失败不影响主流程）
ClassMethod Write(r As PHA.COM.BaseBizPush.Engine.Result.PushResult, ctx As PHA.COM.BaseBizPush.Engine.Context.PushContext="") As %Status
{
	s sc = $$$OK
    if '$isobject(r) {
	    set sc = $$$ERROR($$$GeneralError, "PushResult为空")
	    quit sc
    }

    try {
        set logRowId = r.FacelogId
        set payload = r.ToFrontDTO().%ToJSON()
		if (logRowId '= "") {
			do ##class(PHA.FACE.COM.Log).Log(.logRowId, payload)
		} else {
			#dim dto as %DynamicObject;
	        set dto = {}
	        if $isobject(ctx) {
	            set ctxInfo = {
	                "triggerCode": (ctx.TriggerCode),
	                "hospId": (ctx.HospId),
	                "deptCode": (ctx.DeptCode),
	                "triggerMode": (ctx.TriggerMode),
	                "bizInfo": (ctx.GetBizInfo())
	                // "bizData": (ctx.GetBizData())		// 传递的数据不记录了
	            }
	            if $isobject(ctx.AllowedTargetClasses) {
	                set ctxInfo.allowedTargetClasses = ctx.AllowedTargetClasses
	            }
	            set dto.context = ctxInfo
	            set manualReq = {
	                "entryCode": (ctx.TriggerCode),
	                "hospId": (ctx.HospId),
	                "deptCode": (ctx.DeptCode),
	                "bizInfo": (ctx.GetBizInfo()),
	                "targetClasses": []
	            }
	            if $isobject(ctx.AllowedTargetClasses) {
	                set iter = ctx.AllowedTargetClasses.%GetIterator()
	                while iter.%GetNext(.key, .value) {
	                    if value = 1 {
	                        do manualReq.targetClasses.%Push(key)
	                    }
	                }
	            }
	            // TODO 按照 触发模式(AUTO / MANUAL) 记录不同的调用方法、入参
	            set dto.manualRequest = manualReq
	        }
	        set params = dto.%ToJSON()
	        set user = ##class(PHA.COM.Err).GetSessionVal("LOGON.USERID","")
	        set ip = ##class(PHA.COM.Err).GetSessionVal("CLIENT_ADDR","")
			s r.FacelogId = ##class(PHA.FACE.COM.Log).Log(.logRowId, "", "OP", "PHA.COM.BaseBizPush.Business.App.PushService", "Push", params, "", user, "")  
			// Success = 0 的不管是否成功推送都已经结束不再PushSummary中调用AddResult，直接插入结束日志信息
			if (r.Success = 0) {
				do ##class(PHA.FACE.COM.Log).Log(.logRowId, payload)
			}
	        
		}
    } catch ex {
        set sc = $$$ERROR($$$GeneralError, "记录推送结果日志失败: "_ex.DisplayString())
    }

    quit sc
}
}
