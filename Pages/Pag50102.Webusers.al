/// <summary>
/// Page Web users (ID 50102).
/// </summary>
page 50102 "Web users"
{
    ApplicationArea = All;
    Caption = 'Web users';
    PageType = List;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            field(id; id)
            {
                Caption = 'Id';
                trigger OnValidate()
                var
                    myInt: Integer;
                begin
                    GetApiWeb();
                end;
            }
            field(Name; Name)
            {
                Caption = 'Name';
            }
            field(UserName; UserName)
            {
                Caption = 'UserName';
            }
            field(Email; Email)
            {
                Caption = 'Email';
            }
        }
    }
    local procedure GetApiWeb()
    var
        client: HttpClient;
        Response: HttpResponseMessage;
        Result: Text;
        UserJson: JsonObject;
        JsonToken: JsonToken;
    begin
        if not client.Get('https://jsonplaceholder.typicode.com/users/' + Format(Id), Response) then
            Error('No Api of type retreived');
        if Response.IsSuccessStatusCode() then
            Response.Content().ReadAs(Result);
        UserJson.ReadFrom(Result);
        UserJson.Get('name', JsonToken);
        Name := JsonToken.AsValue().AsText();
        UserJson.Get('username', JsonToken);
        UserName := JsonToken.AsValue().AsText();
        UserJson.Get('email', JsonToken);
        Email := JsonToken.AsValue().AsText();
    end;

    var
        Id: Integer;
        Name: Text;
        UserName: Text;
        Email: Text;
}
