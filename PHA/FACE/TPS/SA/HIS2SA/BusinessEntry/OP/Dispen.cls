// Generated from PHABizPush.xml
// Source export timestamp: 2026-04-29 16:59:43

/// 门诊发药推送入口
Class PHA.FACE.TPS.SA.HIS2SA.BusinessEntry.OP.Dispen Extends PHA.COM.BaseBizPush.Business.BaseBizPushTemplate
{
/// 入口编码（唯一）
Method ActionCode() As %String
{
    Quit "OP_DISPEN"
}

/// 入口名称
Method ActionName() As %String
{
    Quit "门诊发药推送"
}

/// 入口描述
Method ActionDesc() As %String
{
    Quit "门诊西药发药完成后，推送数据"
}

/// 注册声明
/// 一个入口可以注册多个【院区 + 科室 + Target + 平台Code】
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
    Do platformData.%Set("input1", "MES0029")
    Do platformData.%Set("dataFormat", "02")
    Do platformData.%Set("opCode", "HD1005")

    Do reg.AddTarget(
        "PHA.FACE.TPS.SA.HIS2SA.Target.OP.ConsumeTarget",
        "MES0029",
        "web.DHCENS.STBLL.SOAP.PUB0005Soap",
        "HIPMessageInfo",
        platformData
    )

    Do list.Insert(reg)

    Quit list
}

/// 获取业务数据
/// ctx.GetBizInfo().phd = 发药单号
Method GetBizData(ctx As PHA.COM.BaseBizPush.Engine.Context.PushContext) As %DynamicObject
{
    //Set phd = $Get(ctx.BizInfo.phd)
    // 优先使用 BizInfo 统一约定 data.id，兼容历史字段 phd
    Set info = ctx.GetBizInfo()
    Set phd = ##class(PHA.COM.BaseBizPush.Engine.Context.PushBizContextDTO).GetId(info)
    if phd = "" {
        Set phd = info.%Get(phd)
    }
    Quit ##class(PHA.FACE.TPS.SA.HIS2SA.Data.OPDispen).GetPrescDispDetail(phd)
}

/// 本地测试
/// w ##class(PHA.FACE.TPS.SA.HIS2SA.BusinessEntry.OP.Dispen).TestBizPush()
ClassMethod TestBizPush()
{
	s prescNo = "O260209000005"
	s contextData = {}
    s contextData.hospId = ##class(PHA.COM.Err).GetSessionVal("LOGON.HOSPID","2")
    s contextData.deptId = ##class(PHA.OP.COM.Method).GetPrescRecLoc(prescNo)
    s contextData.entryCode = "OP_DISPEN"
    s contextData.bizInfo = {"phd":(123),"prescNo":(prescNo)}
    q ##class(PHA.COM.BaseBizPush.Business.App.PushService).Push(contextData).%ToJSON()
}

ClassMethod tt()
{
	set prescNo = "O260121000004"
	s contextData = {}
    s contextData.deptId = $p(##class(PHA.OP.COM.Method).GetPrescRecLoc(prescNo),"^",2)
    s contextData.hospId = ##class(PHA.COM.Err).GetSessionVal("LOGON.HOSPID",##class(PHA.COM.Data.Base).HospIdByLoc(contextData.deptId))
    s contextData.entryCode = "OP_DISPEN"
    s contextData.bizInfo = {"phd":(281),"prescNo":(prescNo)}
    set ret = ##class(PHA.COM.BaseBizPush.Business.App.PushService).Push(contextData)
    q ret.%ToJSON()
	
    Set ctx = ##class(PHA.COM.BaseBizPush.Engine.Context.PushContext).%New()
    Set ctx.TriggerCode = "OP_DISPEN"
    Set ctx.HospId      = "2"
    Set ctx.DeptCode    = "13"

#;    Set ctx.BizInfo = {}
#;    Set ctx.BizInfo.phd = 281   // 发药单号
    Set info = {}
    Set info.phd = 286   // 发药单号
    Do ctx.SetBizInfo(info)

    Set entry = ##class(PHA.FACE.TPS.SA.HIS2SA.BusinessEntry.OP.Dispen).%New()
    Set summary = entry.Execute(ctx)

    q summary.ToFrontDTO()
}
}
