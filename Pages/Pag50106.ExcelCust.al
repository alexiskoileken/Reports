/// <summary>
/// Page Excel Cust (ID 50106).
/// </summary>
page 50106 "Excel Cust"
{
    ApplicationArea = All;
    Caption = 'Excel Cust';
    PageType = List;
    SourceTable = "Excel Cust";
    UsageCategory = Lists;
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(No; Rec.No)
                {
                    ToolTip = 'Specifies the value of the No field.', Comment = '%';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.', Comment = '%';
                }
                field(Contact; Rec.Contact)
                {
                    ToolTip = 'Specifies the value of the Contact field.', Comment = '%';
                }
                field(City; Rec.City)
                {
                    ToolTip = 'Specifies the value of the City field.', Comment = '%';
                }
            }
        }
    }
}
