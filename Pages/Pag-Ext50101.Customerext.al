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
                    myInt: Integer;
                begin
                    ApiConnect(10);
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
                begin
                    if Confirm(ConfirmMsg) then
                        CustomerDataJson(Rec);
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
    local procedure CustomerDataJson(Cust: Record Customer)
    var
        CustObj: JsonObject;
        CustLedgEntryArr: JsonArray;
        CustLedgEntry: Record "Cust. Ledger Entry";
        CustLedgEntryObj: JsonObject;
        TempBlob: Codeunit "Temp Blob";
        OuStr: OutStream;
        InsStr: InStream;
        Result: Text;
        ToFileName: Text;
    begin
        Clear(CustObj);
        CustObj.Add('CustomerNo', cust."No.");
        CustObj.Add('CustomerName', Cust.Name);

        CustLedgEntry.Reset();
        CustLedgEntry.SetRange("Customer No.", Cust."No.");
        if CustLedgEntry.FindSet() then
            repeat
                Clear(CustLedgEntryObj);
                CustLedgEntry.CalcFields(Amount);
                CustLedgEntryObj.Add('DocumentNo', CustLedgEntry."Document No.");
                CustLedgEntryObj.Add('PostingDate', CustLedgEntry."Posting Date");
                CustLedgEntryObj.Add('Description', CustLedgEntry.Description);
                CustLedgEntryObj.Add('Amount', CustLedgEntry.Amount);
                CustLedgEntryArr.Add(CustLedgEntryObj);
            until CustLedgEntry.Next() = 0;
        CustObj.Add('LedgerEntries', CustLedgEntryArr);
        TempBlob.CreateOutStream(OuStr);
        TempBlob.CreateInStream(InsStr);
        CustObj.WriteTo(OuStr);
        OuStr.WriteText(Result);
        InsStr.ReadText(Result);
        ToFileName := 'Customer.Json';
        DownloadFromStream(InsStr, 'Download json file', '', 'All Files(*.*)|*.*', ToFileName)

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


}

