/// <summary>
/// Codeunit ApiConnect (ID 50102).
/// </summary>
codeunit 50102 ApiConnect
{
    /// <summary>
    /// ApiConnectVal.
    /// </summary>
    /// <param name="ApiConnect">Record ApiConnect.</param>
    procedure ApiConnectVal(var ApiConnect: Record ApiConnect)
    var
        Client: HttpClient;
        Response: HttpResponseMessage;
        OutPut: Text;
        JsonObj: JsonObject;
        JTkn: JsonToken;
    begin
        if not Client.Get('https://jsonplaceholder.typicode.com/users/' + Format(ApiConnect.UserId), Response) then
            Error('No API of This type present');
        if Response.IsSuccessStatusCode then begin
            Response.Content().ReadAs(Output);
            JsonObj.ReadFrom(OutPut);
            JsonObj.Get('name', JTkn);
            ApiConnect.Name := JTkn.AsValue().AsText();

        end;

    end;
}
