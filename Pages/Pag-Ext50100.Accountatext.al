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
        addafter(History)
        {
            action(MyReport)
            {
                ApplicationArea = basic, suite;
                Caption = 'Testing onInit';
                RunObject = report ttriggerstest;
            }
        }
    }
}
