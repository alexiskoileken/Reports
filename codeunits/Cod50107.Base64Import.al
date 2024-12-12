/// <summary>
/// Codeunit Base64Import (ID 50107).
/// </summary>
codeunit 50107 Base64Import
{
    procedure ConvertBase64Toexcel(Base64String: Text)
        var  
        TempBlob: Codeunit "Temp Blob";
       BaseConvert: Codeunit "Base64 Convert";
        ExcelBuffer: Record "Excel Buffer";
        InStream: InStream;
        SheetName: Text;
        OutStream:OutStream;
        ToFile:Text;
        TempFile:Text;
        ExcelCust: Record  "Excel Cust";
    begin
        TempBlob.CreateOutStream(OutStream);
        BaseConvert.FromBase64(Base64String, OutStream);
        TempBlob.CreateInStream(InStream);
        
        SheetName := ExcelBuffer.SelectSheetsNameStream(InStream);
        
         ExcelBuffer.OpenBookStream(InStream,SheetName);
         ExcelBuffer.ReadSheet();
          
          
    
    end;
}


   
