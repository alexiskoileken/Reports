/// <summary>
/// Codeunit Notification (ID 50105).
/// </summary>
codeunit 50105 "Notification"
{
    //TableNo = "Job Queue Entry";
    trigger OnRun()
    var
    begin
    end;

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

    procedure VendorLedgerEntries(VndrLedgerEntryNot: Notification)
    var
        VendLedgEntry: Record "Vendor Ledger Entry";
        GetDataReturnVal: Text;
        vendorLedgerPage: Page "Vendor Ledger Entries";
    begin
        GetDataReturnVal := VndrLedgerEntryNot.GetData('VendNo');
        VendLedgEntry.SetRange(Open, true);
        VendLedgEntry.SetFilter("Vendor No.", '%1', GetDataReturnVal);
        vendorLedgerPage.SetTableView(VendLedgEntry);
        vendorLedgerPage.Run();

    end;

    [IntegrationEvent(false, false)]
    procedure OnPhoneNumberValidate(phone: Code[13])
    begin
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::Notification, 'OnPhoneNumberValidate', '', false, false)]
    procedure OnCellNumberValidate(phone: Code[13])
    var
        ErrorMessage: Label 'The phone number entered is invalid.Please enter a valid phone Number?';
    begin
        if not CheckIfPhoneNumberIsValid(phone) then
            Error(ErrorMessage);

    end;

    local procedure CheckIfPhoneNumberIsValid(phone: code[13]): Boolean
    var
        myInt: Integer;
    begin
        if phone[1] <> '+' then
            exit(false);

        for myInt := 2 to StrLen(phone) do begin
            if not (phone[myInt] in ['0' .. '9']) then
                exit(false);
        end;

        if StrLen(phone) <> 13 then
            exit(false);

        exit(true);

    end;

    [IntegrationEvent(false, false)]
    procedure OnValidateEmailAddress(email: Text[50])
    begin
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::Notification, 'OnValidateEmailAddress', '', false, false)]
    procedure OnValidatEmailAddress(email: Text[50])
    var
        Regex: Codeunit Regex;
        IsMarch: Boolean;
        Pattern: text;
    begin
        Pattern := '^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
        IsMarch := Regex.IsMatch(Email, Pattern);
        if not IsMarch then
            Error('Please enter a valid email adress');

    end;

}
