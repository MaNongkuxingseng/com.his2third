// Generated from PHABizPush.xml
// Source export timestamp: 2026-04-29 16:59:43

/// 人工重推执行请求 DTO
/// Author: Valen MPF
Class PHA.COM.BaseBizPush.DTO.PushExecuteRequestDTO Extends %SerialObject
{
/// 业务入口编码(entry code)
Property EntryCode As %String;

/// 医院ID(hospital id)
Property HospId As %String;

/// 科室ID(department id)
Property DeptCode As %String;

/// 选中的 TargetClass 列表
Property TargetClasses As %ListOfDataTypes [ Collection = list ];

Storage Default
{
<Type>%Storage.Serial</Type>
<State>PushExecuteRequestDTOState</State>
<StreamLocation>^PHA.COM.Ba1EB4.PushExecute768CS</StreamLocation>
<Data name="PushExecuteRequestDTOState">
<Structure>listnode</Structure>
<Subscript />
<Value name="1">
<Value>EntryCode</Value>
</Value>
<Value name="2">
<Value>HospId</Value>
</Value>
<Value name="3">
<Value>DeptCode</Value>
</Value>
<Value name="4">
<Value>TargetClasses</Value>
</Value>
</Data>
}
}
