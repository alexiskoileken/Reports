/// <summary>
/// Page MyApipage (ID 50100).
/// </summary>
page 50100 MyApipage
{
    APIGroup = 'Sales';
    APIPublisher = 'CRONOUS';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'myApipage';
    DelayedInsert = true;
    EntityName = 'Customer';
    EntitySetName = 'Customers';
    PageType = API;
    SourceTable = Customer;
    ODataKeyFields = SystemId;


    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(no; Rec."No.")
                {
                    Caption = 'No.';
                }
                field(name; Rec.Name)
                {
                    Caption = 'Name';
                }
                field(phoneNo; Rec."Phone No.")
                {
                    Caption = 'Phone No.';
                }
            }
        }
    }
}