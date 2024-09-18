/// <summary>
/// Report ttriggerstest (ID 50100).
/// </summary>
report 50100 ttriggerstest
{
    ApplicationArea = All;
    Caption = 'Testing';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(Customer; Customer)
        {
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
    trigger OnInitReport()
    var
        myInt: Integer;
    begin
        Message('On init executed');
    end;
}
