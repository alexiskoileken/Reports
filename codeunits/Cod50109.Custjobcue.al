/// <summary>
/// Codeunit Cust job cue (ID 50109).
/// </summary>
codeunit 50109 "Cust job cue"
{
    trigger OnRun()
    var
        myInt: Integer;
    begin
        CustRankChange();
    end;

    local procedure CustRankChange()
    var
        Cust: Record Customer;
    begin
        Cust.Reset();
        if Cust.FindSet() then
            repeat
                Clear(Cust.Ranks);
                if Cust."Balance (LCY)" < 2000 then
                    Cust.Ranks := Cust.Ranks::low
                else if Cust."Balance (LCY)" < 3000 then
                    Cust.Ranks := Cust.Ranks::Middle
                else
                    Cust.Ranks := Cust.Ranks::High;
                Cust.Modify(true)
            until Cust.Next() = 0

    end;
}
