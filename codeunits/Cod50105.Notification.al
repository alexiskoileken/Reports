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

    [IntegrationEvent(false, false)]
    procedure OnPhoneNumberValidate(phone: Code[13])
    begin
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::Notification, 'OnPhoneNumberValidate', '', false, false)]
    procedure OnCellNumberValidate(phone: Code[13])
    var
        ErrorMessage: Label 'The phone number is invalid. It must start with a + and contain only numbers.';
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
            Error('Not a valid email adress');

    end;

}
