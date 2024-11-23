/// <summary>
/// Codeunit Customer Api  (ID 50103).
/// </summary>
codeunit 50103 "Customer Api "
{
    /// <summary>
    /// CustomerXml.
    /// </summary>
    /// <returns>Return variable CustXml of type XmlDocument.</returns>
    [ServiceEnabled]
    procedure CustomerXml() CustXml: XmlDocument
    var

        ParentNode: XmlElement;
        routeNode: XmlElement;
        XmlDec: XmlDeclaration;
        cust: Record Customer;
        fieldCaption: Text;
        ChildNode: XmlElement;
        TxtValue: XmlText;
        Result: Text;

    begin
        CustXml := XmlDocument.Create();
        XmlDec := XmlDeclaration.Create('V1.0', 'utf-8', '');
        CustXml.SetDeclaration(XmlDec);
        routeNode := XmlElement.Create('Table');
        CustXml.Add(routeNode);
        if cust.FindSet() then
            repeat
                ParentNode := XmlElement.Create('Customer');
                routeNode.Add(ParentNode);
                fieldCaption := cust.FieldCaption("No.");
                ChildNode := XmlElement.Create(fieldCaption);
                TxtValue := XmlText.Create(cust."No.");
                ChildNode.Add(TxtValue);
                ParentNode.Add(ChildNode);

                fieldCaption := cust.FieldCaption(Name);
                ChildNode := XmlElement.Create(fieldCaption);
                TxtValue := XmlText.Create(cust.Name);
                ChildNode.Add(TxtValue);
                ParentNode.Add(ChildNode);

                fieldCaption := cust.FieldCaption(Contact);
                ChildNode := XmlElement.Create(fieldCaption);
                TxtValue := XmlText.Create(cust.Contact);
                ChildNode.Add(TxtValue);
                ParentNode.Add(ChildNode);

                cust.CalcFields(Balance);
                fieldCaption := cust.FieldCaption(Balance);
                ChildNode := XmlElement.Create(fieldCaption);
                TxtValue := XmlText.Create(Format(cust.Balance));
                ChildNode.Add(TxtValue);
                ParentNode.Add(ChildNode);
            until cust.Next() = 0;

        exit(CustXml)
    end;
}
