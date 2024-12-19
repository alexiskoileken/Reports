/// <summary>
/// PageExtension Vendor ext (ID 50103) extends Record Vendor Card.
/// </summary>
pageextension 50103 "Vendor ext" extends "Vendor Card"
{
    trigger OnOpenPage()
    var
        IsVendor: Boolean;
        VendorNotfication: Notification;
    begin
        IsVendor := CheckIfVendorHasTransactions(Rec);
        if IsVendor then begin
            VendorNotfication.Message('This vendor has a posted Transactions.Do you want to view?');
            VendorNotfication.AddAction('Vendors Transaction', Codeunit::Notification, 'VendorLedgerEntries');
            VendorNotfication.SetData('VendNo', Rec."No.");
            VendorNotfication.Send();
        end;

    end;

    local procedure CheckIfVendorHasTransactions(Vendor: Record Vendor): Boolean
    var
        VendLedgEntry: Record "Vendor Ledger Entry";
    begin
        VendLedgEntry.SetRange("Vendor No.", Vendor."No.");
        VendLedgEntry.SetFilter(Amount, '>0');
        VendLedgEntry.CalcFields(Amount);
        if VendLedgEntry.FindFirst() then
            exit(true)
        else
            exit(false)
    end;    
}
