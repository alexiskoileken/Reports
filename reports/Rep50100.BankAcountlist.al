/// <summary>
/// Report Bank Account list (ID 50100).
/// </summary>
report 50100 "Bank Account list"
{
    ApplicationArea = All;
    Caption = 'Bank Account list';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts/BankAccountList.rdl';
    dataset
    {
        dataitem("Bank Account"; "Bank Account")
        {
            RequestFilterFields = "No.", "Date Filter";
            RequestFilterHeading = 'Options';
            column(BankNo; "No.")
            {
            }
            column(BankName; Name)
            {
            }
            column(BankBalance; "Balance (LCY)")
            {
            }
            column(Bank_Branch_No_; "Bank Branch No.")
            {
            }
            column(CompanyName; CompInfo.Name)
            {

            }
            column(CompanyPicture; CompInfo.Picture)
            {
            }
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
    trigger OnPreReport()
    var
        myInt: Integer;
    begin
        CompInfo.Get();
        CompInfo.CalcFields(Picture);
    end;

    var
        CompInfo: Record "Company Information";
}
