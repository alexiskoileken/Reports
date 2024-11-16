/// <summary>
/// Codeunit GetCustomerHighestOrder (ID 50101).
/// </summary>
codeunit 50101 GetCustomerHighestOrder
{
    /// <summary>
    /// GetHighestOrder.
    /// </summary>
    /// <returns>Return value of type Text.</returns>
    procedure GetHighestOrder(): Text
    var
        salesHdr: Record "Sales Header";
    begin
        salesHdr.Reset();
        salesHdr.SetCurrentKey(Amount);
        salesHdr.Ascending(false);
        if salesHdr.FindFirst() then
            exit(StrSubstNo('Highest sales Order is %1', salesHdr."Sell-to Customer Name"))
    end;
}
