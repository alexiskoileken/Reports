/// <summary>
/// Page Consumer image part (ID 50108).
/// </summary>
page 50108 "Consumer image part"
{
    ApplicationArea = All;
    Caption = 'Consumer image part';
    PageType = CardPart;
    SourceTable = Consumer;

    layout
    {
        area(Content)
        {
            field(Images; Rec.Images)
            {
                ToolTip = 'Specifies the value of the Images field.', Comment = '%';
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(TakePicture)
            {
                ApplicationArea = All;
                Caption = 'Take Picture', comment = 'NLB="YourLanguageCaption"';
                Image = Picture;
                trigger OnAction()
                var
                    Camera: Codeunit Camera;
                    OvvrMsg: Label 'The existing Picture will be replaced';
                    PictureInst: InStream;
                    PicName: Text;
                begin
                    Rec.TestField(No);
                    Rec.TestField(name);
                    if rec.Images.HasValue then
                        if not Confirm(OvvrMsg) then
                            exit;
                    if not Camera.IsAvailable() then
                        Error('Camera is not Available');
                    PicName := 'Consmer';
                    if Camera.GetPicture(PictureInst, PicName) then begin
                        Clear(Rec.Images);
                        rec.Images.ImportStream(PictureInst, 'Upload img');
                        rec.Modify(true)
                    end;

                end;
            }
            action(Import)
            {
                ApplicationArea = All;
                Caption = 'Import', comment = 'NLB="YourLanguageCaption"';
                Image = Import;

                trigger OnAction()
                var
                    ConfirmOvvr: Label 'The Existing Picture will be replaced.Do you want to continue?';
                    FromFile: Text;
                    PicInstr: InStream;
                begin
                    Rec.TestField(No);
                    Rec.TestField(name);
                    if rec.Images.HasValue then
                        if not Confirm(ConfirmOvvr) then
                            exit;

                    if File.UploadIntoStream('Upload image', '', 'All Files(*.*)|*.*', FromFile, PicInstr) then begin
                        Clear(Rec.Images);
                        Rec.Images.ImportStream(PicInstr, 'Upload stream');
                        Rec.Modify(true);
                    end;

                end;
            }
            action(Export)
            {
                ApplicationArea = All;
                Caption = 'Export', comment = 'NLB="YourLanguageCaption"';
                Image = Export;
                Enabled = IsEnabled;
                trigger OnAction()
                var
                    TempBlob: Codeunit "Temp Blob";
                    ConMsg: Label 'Do you want to download';
                    PicOut: OutStream;
                    Instr: InStream;
                    ToFile: Text;
                begin
                    Rec.TestField(Images);
                    Rec.TestField(name);
                    Rec.TestField(No);
                    if Rec.Images.HasValue then
                        if not Confirm(ConMsg) then
                            exit;
                    ToFile := 'Consumer.img';
                    TempBlob.CreateOutStream(PicOut);
                    rec.Images.ExportStream(PicOut);
                    TempBlob.CreateInStream(Instr);
                    if File.DownloadFromStream(Instr, 'Download picture', '', 'All Files(*.*)|*.*', ToFile) then
                        Message('Image exported successfully')
                    else
                        Message('Error while exporing');
                end;
            }
        }

    }
    trigger OnAfterGetCurrRecord()
    var
        myInt: Integer;
    begin
        Enabled();
    end;

    local procedure Enabled()
    var
        myInt: Integer;
    begin
        IsEnabled := Rec.Images.HasValue;
    end;

    var
        IsEnabled: Boolean;

}
