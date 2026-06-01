// Generated from PHABizPush.xml
// Source export timestamp: 2026-04-29 16:59:43

/// 推送目标前端展示 DTO
/// Author: Valen MPF
Class PHA.COM.BaseBizPush.DTO.PushTargetDTO Extends %SerialObject
{
/// TargetClass（唯一标识）
Property Key As %String;

/// 显示名称(label)
Property Label As %String;

/// 描述(description)
Property Desc As %String;

/// 业务入口编码(entry code)
Property EntryCode As %String;

/// 医院ID(hospital id)
Property HospId As %String;

/// 科室ID(department id)
Property DeptCode As %String;

/// Target 类全名
Property TargetClass As %String;

/// 平台类(platform class)
Property PlatformClass As %String;

/// 平台方法(platform method)
Property PlatformMethod As %String;

/// 是否支持人工重推
Property SupportRetry As %Boolean;

/// 默认是否选中
Property DefaultSelected As %Boolean;

Storage Default
{
<Type>%Storage.Serial</Type>
<State>PushTargetDTOState</State>
<StreamLocation>^PHA.COM.Base1EB4.PushTargetDTOS</StreamLocation>
<Data name="PushTargetDTOState">
<Structure>listnode</Structure>
<Subscript />
<Value name="1">
<Value>Key</Value>
</Value>
<Value name="2">
<Value>Label</Value>
</Value>
<Value name="3">
<Value>Desc</Value>
</Value>
<Value name="4">
<Value>EntryCode</Value>
</Value>
<Value name="5">
<Value>HospId</Value>
</Value>
<Value name="6">
<Value>DeptCode</Value>
</Value>
<Value name="7">
<Value>TargetClass</Value>
</Value>
<Value name="8">
<Value>PlatformClass</Value>
</Value>
<Value name="9">
<Value>PlatformMethod</Value>
</Value>
<Value name="10">
<Value>SupportRetry</Value>
</Value>
<Value name="11">
<Value>DefaultSelected</Value>
</Value>
</Data>
}
}
