/// <summary>
/// Table ApiConnect (ID 50100).
/// </summary>
table 50100 ApiConnect
{
    Caption = 'ApiConnect';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; UserId; Integer)
        {
            Caption = 'UserId';
            trigger OnValidate()
            var
                ApiConnect: Codeunit ApiConnect;
            begin
                ApiConnect.UserApiConnect(Rec);
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
    }
    keys
    {
        key(PK; UserId)
        {
            Clustered = true;
        }
    }
}
