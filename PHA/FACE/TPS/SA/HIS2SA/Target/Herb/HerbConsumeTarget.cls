// Generated from PHABizPush.xml
// Source export timestamp: 2026-04-29 16:59:43

Class PHA.FACE.TPS.SA.HIS2SA.Target.Herb.HerbConsumeTarget Extends PHA.COM.BaseBizPush.Engine.Target.ITarget
{
Method GetCode() As %String
{
		Quit "HERB_CONSUME"
}

Method GetName() As %String
{
		Quit "草药发药消耗数据推送"
}

Method GetDesc() As %String
{
		Quit "门诊草药发药完成后，推送草药实际消耗数据"
}

Method IsAsync() As %Boolean
{
		Quit 0  // 同步推送
}

Method BuildPayload(bizData As %DynamicObject, ctx As PHA.COM.BaseBizPush.Engine.Context.PushContext) As %Stream.TmpCharacter
{
	Set arr = []
#;	Set prescNo = ctx.BizInfo.prescNo
#;	/// 获取处方的批次发药数据
#;	Set bizData = ##class(PHA.FACE.TPS.SA.HIS2SA.Data.Herb).GetPrescBatchData(prescNo)
	Set dto = ##class(PHA.FACE.TPS.SA.HIS2SA.DTO.DispenseBatchDTO).Build(bizData.data)
	Set tmpData = dto.ToJSONObj()
	Set dataObj = tmpData.header
	Set dataObj."Items" = tmpData.items
	Set arr = ##class(PHA.FACE.TPS.SA.Template.Dto.FlatDtoAdapter).FlattenWithList(dataObj,"Items")
	
	s stream = ##class(%Stream.GlobalCharacter).%New()
	d arr.%ToJSON(.stream)
	Quit stream
}

Method ParseResponse(rawResp As %String) As %DynamicObject
{
    Set result = {}
    Do result.%Set("raw", rawResp)

    If rawResp = "success" {
        Do result.%Set("success", 1)
        Quit result
    }

    Do result.%Set("success", 0)
    Do result.%Set("message", rawResp)
    Quit result
}

Method IsSuccess(parsedResp As %DynamicObject) As %Boolean
{
    Quit parsedResp.success
}

Method BuildResultMessage(parsedResp As %DynamicObject) As %String
{
    Quit $Get(parsedResp.raw, "无返回信息")
}

}
