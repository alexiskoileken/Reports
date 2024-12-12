pageextension 50102 "customer list ext" extends "Customer List"
{
    layout
    {
        addafter(Name)
        {
            field(Ranks; Rec.Ranks)
            {
                ToolTip = 'Specifies the customer ranks in terms of trading done';
            }
        }
    }
    actions
    {
        addfirst(processing)
        {
            action(test)
            {
                ApplicationArea = All;
                Caption = 'test', comment = 'NLB="YourLanguageCaption"';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = TestReport;

                trigger OnAction()
                var
                    Custjobcue: Codeunit "Cust job cue";
                begin
                    Custjobcue.CustRankChange();
                end;
            }
        }
    }
}
