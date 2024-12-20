page 50109 "Consumer card"
{
    ApplicationArea = All;
    Caption = 'Consumer card';
    PageType = Card;
    SourceTable = Consumer;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

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
        area(FactBoxes)
        {
            part(ConsumerPict; "Consumer image part")
            {
                SubPageLink = No = field(No);
                ApplicationArea = Basic, Suite;
            }
        }
    }
}
