/// <summary>
/// Codeunit Cust job cue (ID 50109).
/// </summary>
codeunit 50109 "Cust job cue"
{
    procedure CustRankChange()
    var
        Cust: Record Customer;
    begin
        Cust.Reset();
        if Cust.FindSet() then
            repeat
                if Cust.get() then begin
                    if Cust.Balance >= 3000 then
                        Cust.Ranks := Cust.Ranks::High;
                    if Cust.Balance > 2000 then
                        Cust.Ranks := Cust.Ranks::Middle
                    else
                        Cust.Ranks := Cust.Ranks::low;
                    Cust.Modify(true)
                end
            until Cust.Next() = 0

    end;
}
