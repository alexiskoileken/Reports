/// <summary>
/// Table Excel Cust (ID 50102).
/// </summary>
table 50102 "Excel Cust"
{
    Caption = 'Excel Cust';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; No; Code[20])
        {
            Caption = 'No';
        }
        field(2; Name; Text[50])
        {
            Caption = 'Name';
        }
        field(3; Contact; Text[50])
        {
            Caption = 'Contact';
        }
        field(4; City; Text[100])
        {
            Caption = 'City';
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
