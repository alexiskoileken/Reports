page 50105 "Api Connect image"
{
    ApplicationArea = All;
    Caption = 'Api Connect image';
    PageType = CardPart;
    SourceTable = ApiConnect;
    

    layout
    {
        area(Content)
        {
            group(General)
            {
                ShowCaption = false;
                field(Image; Rec.Image)
                {
                    ToolTip = 'Specifies the value of the Image field.', Comment = '%';
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(TakePicture)
            {
                ApplicationArea = All;
                Caption = 'Take picture';
                Image = Camera;

                trigger OnAction()
                var
                    Camera: Codeunit Camera;
                    CamErrMsg: Label 'Camera is unavailable';
                    OverrideImageQst: Label 'the current picture will be replaced do you want to continue';
                    PictureInstream: InStream;
                    PictureNme: Text;
                begin
                    Rec.TestField(UserId);
                    Rec.TestField(Name);
                    if Rec.Image.HasValue then
                        if not Confirm(OverrideImageQst) then
                            exit;

                    if not Camera.IsAvailable() then
                        Error(CamErrMsg);
                    PictureNme := 'Apiconnect';
                    if Camera.GetPicture(PictureInstream, PictureNme) then begin
                        Clear(Rec.Image);
                        Rec.Image.ImportStream(PictureInstream, PictureNme);
                        Rec.Modify(true);
                    end;
                end;
            }
            action(ImportPicture)
            {
                ApplicationArea = All;
                Caption = 'Import';
                Image = Import;
                ToolTip = 'Import a picture file.';
                trigger OnAction()
                var
                    FileName: Text;
                    ClientFileName: InStream;
                    OverrideImageQst: Label 'the current picture will be replaced do you want to continue';
                begin
                    rec.TestField(UserId);
                    rec.TestField(Name);

                    if Rec.Image.HasValue() then
                        if not Confirm(OverrideImageQst) then
                            exit;

                    FileName := 'img';
                    if File.UploadIntoStream('Upload picture', '', 'All Files(*.*)|*.*', FileName, ClientFileName) then begin
                        Clear(Rec.Image);
                        Rec.Image.ImportStream(ClientFileName, FileName);
                        Rec.Modify(true);
                    end
                end;
            }
            action(Export)
            {
                ApplicationArea = All;
                Caption = 'Export';
                Image = Export;
                Enabled = IsEnabled;
                trigger OnAction()
                var
                    ToFile: Text;
                    ImgPicIstr: InStream;
                    ImgPicOut: OutStream;
                    TempBlob: Codeunit "Temp Blob";
                    ConfirmMsg: Label 'Do you want to dowload picture';

                begin
                    rec.TestField(UserId);
                    rec.TestField(name);
                    Rec.TestField(Image);
                    ToFile := 'Img.jpg';

                    if not Confirm(ConfirmMsg) then
                        exit;


                    TempBlob.CreateOutStream(ImgPicOut);
                    Rec.Image.ExportStream(ImgPicOut);

                    TempBlob.CreateInStream(ImgPicIstr);
                    if File.DownloadFromStream(ImgPicIstr, 'Download image', '', 'All Files(*.*)|*.*', ToFile) then
                        Message('Image exported successfully')
                    else
                        Message('Error while exporing');
                end;

            }
            action(Delete)
            {
                ApplicationArea = All;
                Caption = 'Delete';
                Image = Delete;
                Enabled = IsEnabled;

                trigger OnAction()
                var
                    ConfrmMsg: Label 'Do you want to delete';
                begin
                    rec.TestField(UserId);
                    Rec.TestField(Image);
                    if Rec.Image.HasValue then
                        if not Confirm(ConfrmMsg) then
                            exit;
                    Clear(Rec.Image);
                    rec.Modify(true)
                end;
            }

        }
    }
    trigger OnAfterGetCurrRecord()
    begin
        setEnabledOnActions();
    end;

    local procedure setEnabledOnActions()
    begin
        IsEnabled := rec.Image.HasValue;
    end;


    var
        IsEnabled: Boolean;
}