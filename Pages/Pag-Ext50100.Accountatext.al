/// <summary>
/// PageExtension Accountat ext (ID 50100) extends Record Accountant Role Center.
/// </summary>
pageextension 50100 "Accountat ext" extends "Accountant Role Center"
{
    layout
    {

    }
    actions
    {
        addbefore("G/L Reports")
        {
            group("Bank reports")
            {
                Caption = 'Bank Reports';
                action("Bank Report List")
                {
                    ApplicationArea = basic, suite;
                    Caption = 'Bank Account list';
                    RunObject = report "Bank Account list";
                    Image = Report;
                }
            }
        }
    }
}