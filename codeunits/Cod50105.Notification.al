/// <summary>
/// Codeunit Notification (ID 50105).
/// </summary>
codeunit 50105 "Notification"
{
    procedure CustomerLedgerEnties(LedgerEntrNot: Notification)
    var
        CustLedgEntry: Record "Cust. Ledger Entry";
        ReturnVal: Text;
        CustLedgerPage: Page "Customer Ledger Entries";
    begin
        ReturnVal := LedgerEntrNot.GetData('CustNo');
        CustLedgEntry.SetRange(Open, true);
        CustLedgEntry.SetFilter("Customer No.", '%1', ReturnVal);
        CustLedgerPage.SetTableView(CustLedgEntry);
        CustLedgerPage.Run();
    end;
}
