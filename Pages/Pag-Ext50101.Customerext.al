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
                PromotedIsBig = true;
                Image = Excel;

                trigger OnAction()
                var
                    UpdCust: Codeunit "Update Customer";
                begin
                    UpdCust.Base64Convert();
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

