// Generated from PHABizPush.xml
// Source export timestamp: 2026-04-29 16:59:43

Class PHA.FACE.TPS.SA.HIS2SA.BusinessEntry.OP.Herb.Dispen Extends PHA.COM.BaseBizPush.Business.BaseBizPushTemplate
{
/// 入口编码
Method ActionCode() As %String
{
        Quit "OP_HERB_DISPEN"
}

/// 入口名称
Method ActionName() As %String
{
        Quit "门诊草药发药后推送"
}

/// 入口描述
Method ActionDesc() As %String
{
        Quit "门诊草药发药完成后，推送处方数据"
}

/// 注册声明
Method Registrations() As %ListOfObjects
{
        Set list = ##class(%ListOfObjects).%New()

        Set reg = ##class(PHA.COM.BaseBizPush.Engine.Definition.PushRegistration).%New()
        Set reg.HospId   = "27"
        Set reg.DeptCode = "93"
		
		// 和利康源颗粒剂-发药推送
        Do reg.AddTarget(
            "PHA.FACE.TPS.SA.HIS2SA.Target.Herb.HollysysAppTarget",
            "MES0022",
            "web.DHCENS.STBLL.SOAP.PUB0002Soap",
            "HIPMessageInfo",
            {}
        )
        Do list.Insert(reg)
        
        // 2.其他科室，目标定义
        Set reg = ##class(PHA.COM.BaseBizPush.Engine.Definition.PushRegistration).%New()
        Set reg.HospId   = "ALL"
        Set reg.DeptCode = "ALL"
        // Target 2: SA系统消耗
	    Set platformData = {}
	    Do platformData.%Set("input1", "MES0029")
	    Do platformData.%Set("dataFormat", "02")
	    Do platformData.%Set("opCode", "HD1005")
    
	    Do reg.AddTarget(
	        "PHA.FACE.TPS.SA.HIS2SA.Target.Herb.HerbConsumeTarget",
	        "MES0029",
	        "web.DHCENS.STBLL.SOAP.PUB0005Soap",
	        "HIPMessageInfo",
	        platformData
	    )

		Do list.Insert(reg)
		
        Quit list
}

/// 获取业务数据
Method GetBizData(ctx As PHA.COM.BaseBizPush.Engine.Context.PushContext) As %DynamicObject
{
        Set data = {}
        // Set prescNo     = ctx.BizInfo.prescNo
        // 优先使用 BizInfo 统一约定 data.no，兼容历史字段 prescNo
        Set info = ctx.GetBizInfo()
        Set prescNo = ##class(PHA.COM.BaseBizPush.Engine.Context.PushBizContextDTO).GetNo(info)
        if prescNo = "" {
            Set prescNo = info.prescNo
        }
        
        s data = ##class(PHA.FACE.TPS.SA.HIS2SA.Data.Herb).GetPrescBatchData(prescNo)
        Quit data
}

/// w ##class(PHA.FACE.TPS.SA.HIS2SA.BusinessEntry.OP.Herb.Dispen).TestBizPush()
ClassMethod TestBizPush()
{
	s ctx = ##class(PHA.COM.BaseBizPush.Engine.Context.PushContext).%New()
	s ctx.TriggerCode = "PHA.FACE.TPS.SA.HIS2SA.BusinessEntry.OP.Herb.Dispen"
	s ctx.HospId = "SC001"
	s ctx.DeptCode = "PHA1"
#;	s ctx.BizInfo = {}
#;	s ctx.BizInfo.dispenseId = "123"
#;	s ctx.BizInfo.prescNo = "O251202000004"
	s info = {}
	s info.dispenseId = "93"
	s info.prescNo = "O260401000025"
	d ctx.SetBizInfo(info)
	
	s tpl = ##class(PHA.FACE.TPS.SA.HIS2SA.BusinessEntry.OP.Herb.Dispen).%New()
	s summary = tpl.Execute(ctx)

	q summary.ToFrontDTO().%ToJSON()
	zw summary.GetAllResult()
}

/// w ##class(PHA.FACE.TPS.SA.HIS2SA.BusinessEntry.OP.Herb.Dispen).Push()
ClassMethod Push()
{
	s phbd = 73
	s prescNo = "O260429000048"
	s hospId = 27
	s ctloc = 93
	// 退药入口公共消息推送
    s contextData = {}
    s contextData.hospId = ##class(PHA.COM.Err).GetSessionVal("LOGON.HOSPID",hospId)
    s contextData.deptId = ctloc
    s contextData.entryCode = "OP_HERB_DISPEN"
    s contextData.bizInfo = {"phbd":(phbd),"prescNo":(prescNo)}
    q ##class(PHA.COM.BaseBizPush.Business.App.PushService).Push(contextData)
}
}
