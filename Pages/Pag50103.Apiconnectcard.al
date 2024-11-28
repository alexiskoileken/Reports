page 50103 "Api connect card"
{
    ApplicationArea = All;
    Caption = 'Api connect card';
    PageType = Card;
    SourceTable = ApiConnect;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field(UserId; Rec.UserId)
                {
                    ToolTip = 'Specifies the value of the UserId field.', Comment = '%';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.', Comment = '%';
                }
                field(UserName; Rec.UserName)
                {
                    ToolTip = 'Specifies the value of the UserName field.', Comment = '%';
                }
                field(email; Rec.email)
                {
                    ToolTip = 'Specifies the value of the email field.', Comment = '%';
                }
                field(Phone; Rec.Phone)
                {
                    ToolTip = 'Specifies the value of the Phone field.', Comment = '%';
                }
                field(website; Rec.website)
                {
                    ToolTip = 'Specifies the value of the website field.', Comment = '%';
                }
            }
            group(address)
            {
                Caption = 'address';

                field(Street; Rec.Street)
                {
                    ToolTip = 'Specifies the value of the Street field.', Comment = '%';
                }
                field(suite; Rec.suite)
                {
                    ToolTip = 'Specifies the value of the suite field.', Comment = '%';
                }
                field(city; Rec.city)
                {
                    ToolTip = 'Specifies the value of the city field.', Comment = '%';
                }
                field(ZipCode; Rec.ZipCode)
                {
                    ToolTip = 'Specifies the value of the ZipCode field.', Comment = '%';
                }
            }
            group(geograhy)
            {
                Caption = 'geograhy';

                field(Lat; Rec.Lat)
                {
                    ToolTip = 'Specifies the value of the Lat field.', Comment = '%';
                }
                field(Long; Rec.Long)
                {
                    ToolTip = 'Specifies the value of the Long field.', Comment = '%';
                }
            }
            group(company)
            {
                Caption = 'company';

                field(CName; Rec.CName)
                {
                    ToolTip = 'Specifies the value of the CName field.', Comment = '%';
                }
                field(CatchPhrase; Rec.CatchPhrase)
                {
                    ToolTip = 'Specifies the value of the CatchPhrase field.', Comment = '%';
                }
                field(Bs; Rec.Bs)
                {
                    ToolTip = 'Specifies the value of the Bs field.', Comment = '%';
                }
            }
        }
        area(FactBoxes)
        {
            part(control1; "Api Connect image")
            {
                ApplicationArea = all;
                SubPageLink = UserId = field(UserId);
            }
        }

    }
    actions
    {
        area(Processing)
        {
            action(TesReport)
            {
                ApplicationArea = All;
                Caption = 'Test';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Report;
                RunObject = report BarcodeRep;
            }
        }
    }
}
