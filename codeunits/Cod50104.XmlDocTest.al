/// <summary>
/// Codeunit XmlDocTest (ID 50104).
/// </summary>
codeunit 50104 XmlDocTest
{
    procedure XmlDoc()
    var
        CustXmlDoc: XmlDocument;
        XmlDecl: XmlDeclaration;
        RouteNode: XmlElement;
        ParentNode: XmlElement;
        Cust: Record Customer;
        FieldCaption: Text;
        ChildNode: XmlElement;
        Xmltxt: XmlText;
        OutStr: OutStream;
        Instr: InStream;
        TempBlob: Codeunit "Temp Blob";
        FileName: Text;
    begin
        CustXmlDoc := XmlDocument.Create();
        XmlDecl := XmlDeclaration.Create('1.0', 'UTF-8', '');
        CustXmlDoc.SetDeclaration(XmlDecl);
        RouteNode := XmlElement.Create('Table');
        CustXmlDoc.Add(RouteNode);
        if Cust.FindSet() then
            repeat
                ParentNode := XmlElement.Create('Customer');
                RouteNode.Add(ParentNode);
                FieldCaption := cust.FieldCaption("No.");
                ChildNode := XmlElement.Create(FieldCaption);
                ParentNode.Add(ChildNode);
                Xmltxt := XmlText.Create(Cust."No.");
                ChildNode.Add(Xmltxt);

                FieldCaption := cust.FieldCaption(Name);
                ChildNode := XmlElement.Create(FieldCaption);
                ParentNode.Add(ChildNode);
                Xmltxt := XmlText.Create(Cust.Name);
                ChildNode.Add(Xmltxt);

                FieldCaption := cust.FieldCaption(Contact);
                ChildNode := XmlElement.Create(FieldCaption);
                ParentNode.Add(ChildNode);
                Xmltxt := XmlText.Create(Cust.Contact);
                ChildNode.Add(Xmltxt);

                Cust.CalcFields(Balance);
                FieldCaption := cust.FieldCaption(Balance);
                ChildNode := XmlElement.Create(FieldCaption);
                ParentNode.Add(ChildNode);
                Xmltxt := XmlText.Create(Format(Cust.Balance));
                ChildNode.Add(Xmltxt);

            until Cust.Next() = 0;

        TempBlob.CreateOutStream(OutStr);
        CustXmlDoc.WriteTo(OutStr);
        FileName := 'customer.xml';
        TempBlob.CreateInStream(Instr);
        if DownloadFromStream(Instr, 'Download xml doc', '', 'All files(*.*)|*.*', FileName) then
            Message('File downloaded successful')
        else
            Message('error on downloading');
    end;

    procedure GetApi()
    var
        client: HttpClient;
        HttpPath: Text;
        response: HttpResponseMessage;
        Result: Text;
        CustJsonObj: JsonObject;
    begin
        HttpPath := 'https://jsonplaceholder.typicode.com/users/';
        if not client.Get(HttpPath, response) then
            Error('No Api of this type');

        if response.IsSuccessStatusCode then
            response.Content().ReadAs(result);
        CustJsonObj.ReadFrom(Result);

    end;

    procedure jsonObjCreate(var Customer: Record Customer)
    var
        CustJson: JsonObject;
        result: Text;
        CustLedgEntry: Record "Cust. Ledger Entry";
        CustArr: JsonArray;
        LedgEntrJsn: JsonObject;
        TempBlob: Codeunit "Temp Blob";
        custOut: OutStream;
        CustInst: InStream;
        fromfiles: Text;
    begin
        Clear(CustJson);
        CustJson.Add('CustomerNo', Customer."No.");
        CustJson.Add('CustomerName', Customer.Name);
        CustJson.Add('Contact', Customer.Contact);
        CustJson.Add('LedgerEntries', CustArr);
        CustLedgEntry.Reset();
        CustLedgEntry.SetRange("Customer No.", Customer."No.");
        if CustLedgEntry.FindSet() then
            repeat
                LedgEntrJsn.Add('DocumentNo', CustLedgEntry."Document No.");
                LedgEntrJsn.Add('PostingDate', CustLedgEntry."Posting Date");
                LedgEntrJsn.Add('documentType', Format(CustLedgEntry."Document Type"));
                CustLedgEntry.CalcFields(Amount);
                LedgEntrJsn.Add('Amount', CustLedgEntry.Amount);
                CustArr.Add(LedgEntrJsn);
            until CustLedgEntry.Next() = 0;
        FromFiles := 'customerdata.json';
        TempBlob.CreateOutStream(custOut);
        CustJson.WriteTo(custOut);
        TempBlob.CreateInStream(CustInst);
        if DownloadFromStream(CustInst, '', '', 'All Files (*.*)|*.*', FromFiles) then
            Message('Downloaded file successfully')
        else
            Error('error in dowloading');

    end;

}
