/// <summary>
/// PageExtension Customer ext (ID 50101) extends Record Customer Card.
/// </summary>
pageextension 50101 "Customer ext" extends "Customer Card"
{

    actions
    {
        addfirst(processing)
        {
            action(Client)
            {
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                Caption = 'Client';
                trigger OnAction()
                var
                    XmlDocTest: Codeunit XmlDocTest;
                begin
                    XmlDocTest.XmlDoc();
                end;

            }
            action(Json)
            {
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                Caption = 'Json';
                Image = JobSalesInvoice;
                trigger OnAction()
                var
                    ConfirmMsg: Label 'Do you want to download?';
                    ConfirmElseMsg: Label 'No problem';
                    XmlDocTest: Codeunit XmlDocTest;
                begin
                    XmlDocTest.jsonObjCreate(Rec);
                end;
            }
            action(Excel)
            {
                ApplicationArea = All;
                Caption = 'Excel file', comment = 'NLB="YourLanguageCaption"';
                Promoted = true;
                PromotedCategory = Process;
                Image = Excel;

                trigger OnAction()
                var
                    UpdCust: Codeunit "Update Customer";
                begin
                    UpdCust.Base64Convert();
                end;
            }
            action(base64)
            {
                ApplicationArea = All;
                Caption = 'base64', comment = 'NLB="YourLanguageCaption"';
                Promoted = true;
                PromotedCategory = Process;
                Image = Calculate;

                trigger OnAction()
                var
                    BaseImp: Codeunit Base64Import;
                    Encoded: Text;
                    TempBlob: Codeunit "Temp Blob";
                begin
                    Encoded := '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';
                    BaseImp.ConvertBase64Toexcel(Encoded);
                end;
            }
            action(Convert)
            {
                ApplicationArea = All;
                Caption = 'convert', comment = 'NLB="YourLanguageCaption"';
                Promoted = true;
                PromotedCategory = Process;
                Image = Excel;

                trigger OnAction()
                var
                    ExcelFile: Codeunit ExcelFile;
                begin
                    ExcelFile.ConvertExcelToBase64();
                end;
            }

        }
    }
    local procedure Mtest()
    var
        client: HttpClient;
        content: HttpContent;
        HttpResponseMessage: HttpResponseMessage;
        result: text;
    begin
        client.Get('http://alexis:7047/BC210/WS/CRONUS%20International%20Ltd./Codeunit/HighestSalesOrder', HttpResponseMessage);
        if HttpResponseMessage.IsSuccessStatusCode() then begin
            HttpResponseMessage.Content().ReadAs(result);
            Message(result);
        end;

    end;

    procedure GetUserInformation()
    var
        Client: HttpClient;
        ResponseMessage: HttpResponseMessage;
        ResponseString: Text;
    begin
        if not Client.Get(('http://localhost:8080/BC210/'), ResponseMessage) then
            Error('The call to the web service failed.');

        if not ResponseMessage.IsSuccessStatusCode() then
            Error('The web service returned an error message:\\' +
                    'Status code: ' + Format(ResponseMessage.HttpStatusCode()) +
                    'Description: ' + ResponseMessage.ReasonPhrase());

        ResponseMessage.Content().ReadAs(ResponseString);
        Message(ResponseString);
    end;
    //customer
    local procedure CustomerDataJson(Cust: Record Customer) CustObj: JsonObject;
    var

        CustLedgEntry: Record "Cust. Ledger Entry";
        CustObjArr: JsonArray;
        LdgerEntr: JsonObject;
        TempBlob: Codeunit "Temp Blob";
        OutStr: OutStream;
        InStr: InStream;
        Result: Text;
        ToFileName: Text;
        LocationObj: JsonObject;
        LocationArr: JsonArray;

    begin
        Clear(CustObj);
        CustObj.Add('CustomerNo', Cust."No.");
        CustObj.Add('CustomerName', Cust.Name);
        CustObj.Add('Email', cust."E-Mail");
        CustObj.Add('SecondName', Cust."Search Name");

        CustLedgEntry.Reset();
        CustLedgEntry.SetRange("Customer No.", cust."No.");
        if CustLedgEntry.FindSet() then
            repeat
                Clear(LdgerEntr);
                CustLedgEntry.CalcFields(Amount);
                LdgerEntr.Add('DocumentNo', CustLedgEntry."Document No.");
                LdgerEntr.Add('PostingDate', CustLedgEntry."Posting Date");
                LdgerEntr.Add('Description', CustLedgEntry.Description);
                LdgerEntr.Add('Amount', CustLedgEntry.Amount);
                CustObjArr.Add(LdgerEntr);
            until CustLedgEntry.Next() = 0;
        CustObj.Add('LedgerEntries', CustObjArr);
        Clear(LocationObj);
        LocationObj.Add('Adress', Cust.Address);
        LocationObj.Add('Adress2', cust."Address 2");
        LocationObj.Add('City', Cust.City);
        LocationObj.Add('Country', Cust."Country/Region Code");
        LocationArr.Add(LocationObj);
        CustObj.Add('Location', LocationArr);
        exit(CustObj)
    end;



    local procedure ApiConnect(UserId: Integer)
    var
        Client: HttpClient;
        Response: HttpResponseMessage;
        Content: HttpContent;
        Result: Text;
    begin
        Client.Get('https://jsonplaceholder.typicode.com/posts', Response);
        if Response.IsSuccessStatusCode then
            Response.Content().ReadAs(Result);
        Message(Result);
    end;

    var
    trigger OnOpenPage()
    var
        NotInform: Notification;
        IsCustomer: Boolean;

    begin
        IsCustomer := LedgerEntry(Rec);
        if IsCustomer then begin
            NotInform.Message('Customer has transaction. Do you want to view?');
            NotInform.AddAction('Cust ledger entries', Codeunit::Notification, 'CustomerLedgerEnties');
            NotInform.SetData('CustNo', Rec."No.");
            NotInform.Send()
        end
    end;

    local procedure LedgerEntry(Customer: Record Customer): Boolean
    var
        CustLedgEntry: Record "Cust. Ledger Entry";
    begin
        CustLedgEntry.SetRange("Customer No.", Customer."No.");
        CustLedgEntry.SetFilter(Amount, '>0');
        CustLedgEntry.CalcFields(Amount);
        if CustLedgEntry.FindFirst() then
            exit(true)
        else
            exit(false)
    end;
}

