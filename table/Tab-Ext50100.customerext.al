/// <summary>
/// TableExtension customer ext (ID 50100) extends Record Customer.
/// </summary>
tableextension 50100 "customer ext" extends Customer
{
    fields
    {
        field(50100; "Customer State"; Text[50])
        {
            Caption = 'Customer State';
            DataClassification = ToBeClassified;
        }
    }
}
