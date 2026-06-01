// Generated from PHABizPush.xml
// Source export timestamp: 2026-04-29 16:59:43

// /*
// * web.DHCENS.STBLL.SOAP.PUB0002Soap 平台适配器
// * 适配方法：
// *   HIPMessageInfo(msgCode,data)
// */
Class PHA.FACE.TPS.SA.HIS2SA.Platforms.Adapter.PUB0002Soap Extends PHA.COM.BaseBizPush.Engine.Platform.Adapter.PlatformAdapter
{
Method Invoke(ctx As PHA.COM.BaseBizPush.Engine.Platform.Context.PlatformInvokeContext) As %Status
{
    #dim sc As %Status = $$$OK
    #dim msgCode As %String
    #dim streamData As %Stream.TmpCharacter
    //#dim streamData As %String


    // 固定参数内聚
    s msgCode     = ctx.PlatformCode  ; 平台接入号
    s streamData = ctx.Payload       ; JSON
	
	s platform = ##class(web.DHCENS.STBLL.SOAP.PUB0002Soap).%New()
    // 平台调用
    s ctx.RawResponse = platform.HIPMessageInfo(
        msgCode,
        streamData
    )

    q sc
}

Method GetPlatformInfo() As %String
{
    quit "SA和利康源颗粒剂调剂设备"
}
}
