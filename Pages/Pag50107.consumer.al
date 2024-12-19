page 50107 consumers
{
    ApplicationArea = All;
    Caption = 'consumers';
    PageType = List;
    SourceTable = Consumer;
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
                field(name; Rec.name)
                {
                    ToolTip = 'Specifies the value of the name field.', Comment = '%';
                }
                field(surname; Rec.surname)
                {
                    ToolTip = 'Specifies the value of the surname field.', Comment = '%';
                }
            }
        }
    }
}
