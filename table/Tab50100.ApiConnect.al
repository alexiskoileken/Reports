/// <summary>
/// Table ApiConnect (ID 50100).
/// </summary>
table 50100 ApiConnect
{
    Caption = 'ApiConnect';
    DataClassification = ToBeClassified;
    LookupPageId = "Apiconnect list";
    DrillDownPageId = "Apiconnect list";

    fields
    {
        field(1; UserId; Integer)
        {
            Caption = 'UserId';
            trigger OnValidate()
            var
                ApiConnect: Codeunit ApiConnect;
            begin
                ApiConnect.ApiConnectVal(Rec);
            end;
        }
        field(2; Name; Text[50])
        {
            Caption = 'Name';
        }
        field(3; UserName; Text[50])
        {
            Caption = 'UserName';
        }
        field(4; email; Text[50])
        {
            Caption = 'email';
            trigger OnValidate()
            var
                Notif: Codeunit Notification;
            begin
                Notif.OnValidateEmailAddress(Rec.email);
            end;
        }
        field(5; Street; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(6; suite; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(7; city; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(8; ZipCode; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(9; Lat; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10; Long; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(11; Phone; Code[13])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                Notif: Codeunit Notification;
            begin
                Notif.OnPhoneNumberValidate(Rec.Phone);
            end;
        }
        field(12; website; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(13; CName; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(14; CatchPhrase; Code[100])
        {

        }
        field(15; Bs; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(20; Image; Media)
        {

        }
        field(19; Indentation; Integer)
        {
            Caption = 'Indentation';
            MinValue = 0;

            trigger OnValidate()
            begin
                if Indentation < 0 then
                    Indentation := 0;
            end;
        }
        field(21; status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = ,open,pending,closed;
        }
    }
    keys
    {
        key(PK; UserId)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; UserId, Name, UserName) { }
    }
}
