// Generated from PHABizPush.xml
// Source export timestamp: 2026-04-29 16:59:43

/// 退药批次明细 DTO
Class PHA.FACE.TPS.SA.HIS2SA.DTO.RefundBatchItem Extends %RegisteredObject
{
/// 客户（患者登记号）
Property FCustomerID As %String;

/// 医嘱ID
Property Order As %String;

/// 药品代码
Property FMaterialID As %String;

/// 药品名称
Property FMaterialIDdesc As %String;

/// 退药单位
Property FUnitID As %String;

/// 实际退药数量（负数）
Property FRealQty As %String;

/// 含税单价
Property FTaxPrice As %String;

/// 税率
Property FEntryTaxRate As %String;

/// 退药金额（负数）
Property ypssje As %String;

/// 批号
Property Ypph As %String;

/// 批次号
Property Batid As %String;

Method ToJSONObj() As %DynamicObject
{
    Set json = {}
    Do json.%Set("FCustomerID", ..FCustomerID)
    Do json.%Set("Order", ..Order)
    Do json.%Set("FMaterialID", ..FMaterialID)
    Do json.%Set("FMaterialIDdesc", ..FMaterialIDdesc)
    Do json.%Set("FUnitID", ..FUnitID)
    Do json.%Set("FRealQty", ..FRealQty, "string")
    Do json.%Set("FTaxPrice", ..FTaxPrice, "string")
    Do json.%Set("FEntryTaxRate", ..FEntryTaxRate, "string")
    Do json.%Set("ypssje", ..ypssje, "string")
    Do json.%Set("Ypph", ..Ypph)
    Do json.%Set("Batid", ..Batid)
    Quit json
}
}
