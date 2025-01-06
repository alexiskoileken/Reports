/// <summary>
/// Codeunit Update Customer (ID 50106).
/// </summary>
codeunit 50106 "Update Customer"
{
    TableNo = "Job Queue Entry";
    trigger OnRun()
    var
        myInt: Integer;
    begin
        case Rec."Parameter String" of
            'Customer':
                CustomerNameUpdate();
            'Vendor':
                VendorNameUpdate();
        end;
    end;

    local procedure CustomerNameUpdate()
    var
        Customer: Record Customer;
    begin
        Customer.SetCurrentKey(Balance);
        if Customer.FindFirst() then
            if Customer."Name 2" = '' then begin
                Customer."Name 2" := 'Least sales';
                Customer.Modify(true)
            end;
    end;

    local procedure VendorNameUpdate()
    var
        Vendor: Record Vendor;
    begin
        Vendor.SetCurrentKey(Balance);
        Vendor.Ascending(false);
        if Vendor.FindFirst() then
            if Vendor."Name 2" = '' then begin
                Vendor."Name 2" := 'Biggest sales';
                Vendor.Modify(true)
            end;
    end;

    local procedure MyProcedure()
    var
        myInt: Integer;
    begin

    end;

    procedure Base64Convert()
    var
        TmpExcelBuf: Record "Excel Buffer" temporary;
        Customer: Record Customer;
        SheetName: Text;
        BaseConvert: Codeunit "Base64 Convert";
        ResultOutStrm: OutStream;
        TempBlob: Codeunit "Temp Blob";
        Base64String: Text;
        ResultInStrm: InStream;
    begin
        TmpExcelBuf.Reset();
        TmpExcelBuf.DeleteAll();
        TmpExcelBuf.NewRow();

        TmpExcelBuf.AddColumn(Customer.FieldCaption("No."), false, '', true, false, false, '', TmpExcelBuf."Cell Type"::Text);
        TmpExcelBuf.AddColumn(Customer.FieldCaption(Name), false, '', true, false, false, '', TmpExcelBuf."Cell Type"::Text);
        TmpExcelBuf.AddColumn(Customer.FieldCaption("Name 2"), false, '', true, false, false, '', TmpExcelBuf."Cell Type"::Text);
        TmpExcelBuf.AddColumn(Customer.FieldCaption(Contact), false, '', true, false, false, '', TmpExcelBuf."Cell Type"::Text);
        TmpExcelBuf.AddColumn(Customer.FieldCaption(Balance), false, '', true, false, false, '', TmpExcelBuf."Cell Type"::Text);
        TmpExcelBuf.AddColumn(Customer.FieldCaption("Location Code"), false, '', true, false, false, '', TmpExcelBuf."Cell Type"::Text);


        if Customer.FindSet() then
            repeat
                TmpExcelBuf.NewRow();
                Customer.CalcFields(Balance);
                TmpExcelBuf.AddColumn(Customer."No.", false, '', false, false, false, '', TmpExcelBuf."Cell Type"::Number);
                TmpExcelBuf.AddColumn(Customer.Name, false, '', false, false, false, '', TmpExcelBuf."Cell Type"::Text);
                TmpExcelBuf.AddColumn(Customer.Contact, false, '', false, false, false, '', TmpExcelBuf."Cell Type"::Text);
                TmpExcelBuf.AddColumn(Customer.Balance, false, '', false, false, false, '', TmpExcelBuf."Cell Type"::Number);
                TmpExcelBuf.AddColumn(Customer."Location Code", false, '', false, false, false, '', TmpExcelBuf."Cell Type"::Text);
            until Customer.Next() = 0;
        SheetName := 'CustomerData';
        TempBlob.CreateOutStream(ResultOutStrm);
        TmpExcelBuf.CreateNewBook(SheetName);
        TmpExcelBuf.WriteSheet(SheetName, CompanyName, UserId);
        TmpExcelBuf.CloseBook();
        TmpExcelBuf.SaveToStream(ResultOutStrm, false);

        TempBlob.CreateInStream(ResultInStrm);
        Base64String := BaseConvert.ToBase64(ResultInStrm);
        Message(Base64String);
    end;
}
