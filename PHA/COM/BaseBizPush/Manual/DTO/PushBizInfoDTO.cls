// Generated from PHABizPush.xml

/// Manual retry biz info DTO.
Class PHA.COM.BaseBizPush.Manual.DTO.PushBizInfoDTO Extends %SerialObject
{
Property Id As %String;

Property No As %String;

Property Phd As %String;

Property RefundId As %String;

Property DspId As %String;

Property PhdReturn As %String;

Property PrescNo As %String;

Property BillNo As %String;

Property Ext As %DynamicObject;

Method %OnNew() As %Status
{
    if '$isobject(..Ext) {
        set ..Ext = {}
    }
    quit $$$OK
}

Method ToDynamicObject() As %DynamicObject
{
    set o = {
        "data": {
            "id": (..Id),
            "no": (..No)
        },
        "ext": {}
    }

    if $isobject(..Ext) {
        set o.ext = ..Ext
    }

    quit o
}

ClassMethod FromDynamicObject(dyn As %DynamicObject) As PHA.COM.BaseBizPush.Manual.DTO.PushBizInfoDTO
{
    set dto = ..%New()
    if '$isobject(dyn) quit dto

    if dyn.%IsDefined("data") && $isobject(dyn.data) {
        set dto.Id = $get(dyn.data.id)
        set dto.No = $get(dyn.data.no)
    }

    if dto.Id="" set dto.Id = $get(dyn.id)
    if dto.No="" set dto.No = $get(dyn.no)

    set dto.Phd = $get(dyn.phd)
    set dto.RefundId = $get(dyn.refundId)
    set dto.DspId = $get(dyn.dspId)
    set dto.PhdReturn = $get(dyn.phdReturn)
    set dto.PrescNo = $get(dyn.prescNo)
    set dto.BillNo = $get(dyn.billNo)

    if dto.Id="" set dto.Id = $select(dto.Phd'="":dto.Phd,dto.DspId'="":dto.DspId,dto.RefundId'="":dto.RefundId,dto.PhdReturn'="":dto.PhdReturn,1:"")
    if dto.No="" set dto.No = $select(dto.PrescNo'="":dto.PrescNo,dto.BillNo'="":dto.BillNo,1:"")

    if dyn.%IsDefined("ext") && $isobject(dyn.ext) {
        set dto.Ext = dyn.ext
    }

    quit dto
}

Storage Default
{
<Type>%Storage.Serial</Type>
<State>PushBizInfoDTOState</State>
<StreamLocation>^PHA.COM.BasA905.PushBizInfoDTOS</StreamLocation>
<Data name="PushBizInfoDTOState">
<Structure>listnode</Structure>
<Subscript />
<Value name="1">
<Value>Id</Value>
</Value>
<Value name="2">
<Value>No</Value>
</Value>
<Value name="3">
<Value>Ext</Value>
</Value>
<Value name="4">
<Value>Phd</Value>
</Value>
<Value name="5">
<Value>RefundId</Value>
</Value>
<Value name="6">
<Value>DspId</Value>
</Value>
<Value name="7">
<Value>PhdReturn</Value>
</Value>
<Value name="8">
<Value>PrescNo</Value>
</Value>
<Value name="9">
<Value>BillNo</Value>
</Value>
</Data>
}
}
