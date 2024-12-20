table 50101 Consumer
{
    Caption = 'Consumer';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; No; Code[20])
        {
            Caption = 'No';
        }
        field(2; name; Text[50])
        {
            Caption = 'name';
            //TableRelation = ApiConnect;
        }
        field(3; surname; Text[50])
        {
            Caption = 'surname';
        }
        field(4; Images; Media)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; No)
        {
            Clustered = true;
        }
    }
}
