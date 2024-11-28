/// <summary>
/// Codeunit Customer Api  (ID 50103).
/// </summary>
codeunit 50103 "Customer Api "
{
    /// <summary>
    /// CustomerXml.
    /// </summary>
    /// <returns>Return variable CustXml of type XmlDocument.</returns>

    procedure CustomerXml(var Cust: Record Customer)
    var
        XmlDoc: XmlDocument;
        xmlDec: XmlDeclaration;
        RouteNode: XmlElement;
        ParentNode: XmlElement;
        ChildNode: XmlElement;
        FieldCap: Text;
        CustomerData: XmlText;
        XmlDocOut: OutStream;
        XmlDocInst: InStream;
        TempBlob: Codeunit "Temp Blob";
        ToFile: Text;
        CustLedgEntry: Record "Cust. Ledger Entry";
    begin
        XmlDoc := XmlDocument.Create();
        xmlDec := XmlDeclaration.Create('1.0', 'utf-8', '');
        XmlDoc.SetDeclaration(xmlDec);
        RouteNode := XmlElement.Create('Table');
        XmlDoc.Add(RouteNode);
        if Cust.FindFirst() then
            repeat
                ParentNode := XmlElement.Create('Customer');
                RouteNode.Add(ParentNode);
                FieldCap := Cust.FieldCaption("No.");
                ChildNode := XmlElement.Create(FieldCap);
                CustomerData := XmlText.Create(Cust."No.");
                ChildNode.Add(CustomerData);
                ParentNode.Add(ChildNode);

                FieldCap := Cust.FieldCaption(Name);
                ChildNode := XmlElement.Create(FieldCap);
                CustomerData := XmlText.Create(Cust.Name);
                ChildNode.Add(CustomerData);
                ParentNode.Add(ChildNode);

                FieldCap := Cust.FieldCaption(Contact);
                ChildNode := XmlElement.Create(FieldCap);
                CustomerData := XmlText.Create(Cust.Contact);
                ChildNode.Add(CustomerData);
                ParentNode.Add(ChildNode);


                FieldCap := Cust.FieldCaption(Balance);
                ChildNode := XmlElement.Create(FieldCap);
                CustomerData := XmlText.Create(Format(Cust.CalcFields(Balance)));
                ChildNode.Add(CustomerData);
                ParentNode.Add(ChildNode);

            until Cust.Next() = 0;
        CustLedgEntry.Reset();
        CustLedgEntry.SetRange("Customer No.", Cust."No.");
        if CustLedgEntry.FindSet() then
            repeat
                FieldCap := CustLedgEntry.FieldCaption("Posting Date");
                ChildNode.Add(FieldCap);
                CustomerData := XmlText.Create(Format(CustLedgEntry."Posting Date"));
                ChildNode.Add(CustomerData);
                ParentNode.Add(ChildNode);

                FieldCap := CustLedgEntry.FieldCaption("Document No.");
                ChildNode.Add(FieldCap);
                CustomerData := XmlText.Create(Format(CustLedgEntry."Document No."));
                ChildNode.Add(CustomerData);
                ParentNode.Add(ChildNode);

                FieldCap := CustLedgEntry.FieldCaption("Document Type");
                ChildNode.Add(FieldCap);
                CustomerData := XmlText.Create(Format(CustLedgEntry."Document Type"));
                ChildNode.Add(CustomerData);
                ParentNode.Add(ChildNode)
            until CustLedgEntry.Next() = 0;
        TempBlob.CreateOutStream(XmlDocOut);
        XmlDoc.WriteTo(XmlDocOut);
        ToFile := 'customer.xml';
        TempBlob.CreateInStream(XmlDocInst);
        DownloadFromStream(XmlDocInst, 'Dowload xml file', '', 'All Files(*.*)|*.*', ToFile)
    end;

    var
        v: Record "Tenant Media" temporary;
        ABSCntrClient: Codeunit "ABS Container Client";
        FileRec: File;


}
