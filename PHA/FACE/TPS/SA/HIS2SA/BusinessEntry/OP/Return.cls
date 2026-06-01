// Generated from PHABizPush.xml
// Source export timestamp: 2026-04-29 16:59:43

Class PHA.FACE.TPS.SA.HIS2SA.BusinessEntry.OP.Return Extends PHA.COM.BaseBizPush.Business.BaseBizPushTemplate
{
Method ActionCode() As %String
{
    Quit "OP_RETURN"
}

Method ActionName() As %String
{
    Quit "门诊退药推送"
}

Method ActionDesc() As %String
{
    Quit "门诊西药退药完成后，推送退药数据"
}

Method Registrations() As %ListOfObjects
{
    Set list = ##class(%ListOfObjects).%New()

    // =========================
    // 示例：SC001 医院 PHA1 药房
    // =========================
    Set reg = ##class(PHA.COM.BaseBizPush.Engine.Definition.PushRegistration).%New()
    Set reg.HospId   = "ALL"
    Set reg.DeptCode = "ALL"
    // Target 2: SA系统消耗
    Set platformData = {}
    Do platformData.%Set("input1", "MES0030")
    Do platformData.%Set("dataFormat", "02")
    Do platformData.%Set("opCode", "HD1006")

    Do reg.AddTarget(
        "PHA.FACE.TPS.SA.HIS2SA.Target.OP.ReturnConsumeTarget",
        "MES0030",
        "web.DHCENS.STBLL.SOAP.PUB0005Soap",
        "HIPMessageInfo",
        platformData
    )

	Do list.Insert(reg)

    Quit list
}

Method GetBizData(ctx As PHA.COM.BaseBizPush.Engine.Context.PushContext) As %DynamicObject
{
    // Set phdReturn = $Get(ctx.BizInfo.phdReturn)
    Set info = ctx.GetBizInfo()
    Set phdReturn = info.phdReturn
    Quit ##class(PHA.FACE.TPS.SA.HIS2SA.Data.OPReturn).GetPrescReturnDetail(phdReturn)
}

Method TestBizPush() As %String
{
    Set ctx = ##class(PHA.COM.BaseBizPush.Engine.Context.PushContext).%New()
    Set ctx.TriggerCode = "OP_RETURN"
    Set ctx.HospId      = "SC001"
    Set ctx.DeptCode    = "PHA1"

#;    Set ctx.BizInfo = {}
#;    Set ctx.BizInfo.phdReturn = 101   // 退药单号
    Set info = {}
    Set info.phdReturn = 101   // 退药单号
    Do ctx.SetBizInfo(info)

    Set entry = ##class(PHA.FACE.TPS.SA.HIS2SA.BusinessEntry.OP.Return).%New()
    Set summary = entry.Execute(ctx)

    Quit summary.ToFrontDTO().%ToJSON()
}

/// w ##class(PHA.FACE.TPS.SA.HIS2SA.BusinessEntry.OP.Return).TestBizDataPush()
ClassMethod TestBizDataPush()
{
	s ctloc = 94
	s retrow = 3,prescNo="O260319000008"
	s contextData = {}
	s contextData.deptId = ctloc
    s contextData.hospId = ##class(PHA.COM.Err).GetSessionVal("LOGON.HOSPID",##class(PHA.COM.Data.Base).HospIdByLoc(contextData.deptId))
    s contextData.entryCode = "OP_RETURN"
    s contextData.bizInfo = {"phdReturn":(retrow),"prescNo":(prescNo)}
    s contextStr = contextData.%ToJSON()
    w ##class(PHA.COM.BaseBizPush.Business.App.PushService).Push(contextStr).%ToJSON()
    q 0
}
}
