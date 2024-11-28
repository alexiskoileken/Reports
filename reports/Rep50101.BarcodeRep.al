/// <summary>
/// Report BarcodeRep (ID 50101).
/// </summary>
report 50101 BarcodeRep
{
    ApplicationArea = All;
    Caption = 'BarcodeRep';
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts/bars.rdl';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(Item; Item)
        {
            column(No; "No.")
            {
            }
            column(Description; Description)
            {
            }
            column(BarcodeStr; BarcodeStr)
            {
            }
            trigger OnAfterGetRecord()
            var
                Barcode: Text;
                BarcodeSymbology: Enum "Barcode Symbology";
                BarcodeFontProvider: Interface "Barcode Font Provider";
            begin
                BarcodeFontProvider := Enum::"Barcode Font Provider"::IDAutomation1D;
                BarcodeSymbology := Enum::"Barcode Symbology"::Code39;
                Barcode := "No.";
                BarcodeFontProvider.ValidateInput(Barcode, BarcodeSymbology);
                BarcodeStr := BarcodeFontProvider.EncodeFont(Barcode, BarcodeSymbology)
            end;
        }
    }
    var
        BarcodeStr: Text;
}
