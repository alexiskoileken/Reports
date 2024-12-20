/// <summary>
/// Page Apiconnect list (ID 50101).
/// </summary>
page 50101 "Apiconnect list"
{
    ApplicationArea = All;
    Caption = 'Apiconnect list';
    PageType = List;
    SourceTable = ApiConnect;
    UsageCategory = Lists;
    CardPageId = "Api connect card";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                IndentationColumn = NameIndent;
                IndentationControls = Name;
                ShowCaption = false;
                field(UserId; Rec.UserId)
                {
                    ToolTip = 'Specifies the value of the UserId field.', Comment = '%';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.', Comment = '%';
                }
                field(UserName; Rec.UserName)
                {
                    ToolTip = 'Specifies the value of the UserName field.', Comment = '%';
                }
                field(email; Rec.email)
                {

                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(TesReport)
            {
                ApplicationArea = All;
                Caption = 'Test';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Report;
                trigger OnAction()
                var
                    myInt: Integer;
                begin
                    Report.Run(Report::BarcodeRep);
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        NameIndent := rec.Indentation;
    end;

    var
        [InDataSet]
        NameIndent: Integer;

}
