/// <summary>
/// Codeunit ApiConnect (ID 50102).
/// </summary>
codeunit 50102 ApiConnect
{
    procedure UserApiConnect(ApiConnect: Record ApiConnect)
    var
        Client: HttpClient;
        Response: HttpResponseMessage;
        Content: HttpContent;
        Result: Text;
        UserJobjct: JsonObject;
        JToken: JsonToken;

    begin
        Client.Get('https://jsonplaceholder.typicode.com/users/' + Format(ApiConnect.UserId), Response);
        if Response.IsSuccessStatusCode then begin
            Content := Response.Content;
            Content.ReadAs(Result);
            UserJobjct.ReadFrom(Result);
            UserJobjct.Get('name', JToken);
            ApiConnect.Name := JToken.AsValue().AsText();
            UserJobjct.Get('username', JToken);
            ApiConnect.UserName := JToken.AsValue().AsText();
        end;
    end;
}
