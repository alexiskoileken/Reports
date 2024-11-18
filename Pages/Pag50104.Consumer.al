page 50104 Consumer
{
    APIGroup = 'test';
    APIPublisher = 'tailor';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'consumer';
    DelayedInsert = true;
    EntityName = 'consumer';
    EntitySetName = 'consumers';
    PageType = API;
    SourceTable = Consumer;
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
                field(no; Rec.No)
                {
                    Caption = 'No';
                }
                field(name; Rec.name)
                {
                    Caption = 'name';
                }
                field(surname; Rec.surname)
                {
                    Caption = 'surname';
                }
            }
        }
    }
}
