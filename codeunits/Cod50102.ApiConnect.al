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
        AdrrsJObjct: JsonObject;
        adrrssTkn: JsonToken;
        Adrrss: Text;
    begin
        if not Client.Get('https://jsonplaceholder.typicode.com/users/' + Format(ApiConnect.UserId), Response) then
            Error('No API of This type present');
        if Response.IsSuccessStatusCode then begin
            Response.Content().ReadAs(Output);
            JsonObj.ReadFrom(OutPut);
            JsonObj.Get('name', JTkn);
            ApiConnect.Name := JTkn.AsValue().AsText();
            JsonObj.Get('username', JTkn);
            ApiConnect.UserName := JTkn.AsValue().AsText();
            JsonObj.Get('email', JTkn);
            ApiConnect.email := JTkn.AsValue().AsText();
            JsonObj.Get('phone', JTkn);
            ApiConnect.Phone := JTkn.AsValue().AsText();
            JsonObj.Get('website', JTkn);
            ApiConnect.website := JTkn.AsValue().AsText();
            JsonObj.Get('address', JTkn);
            if JTkn.IsObject then begin
                JTkn.WriteTo(Adrrss);
                AdrrsJObjct.ReadFrom(Adrrss);
                AdrrsJObjct.Get('street', adrrssTkn);
                ApiConnect.Street := adrrssTkn.AsValue().AsText();
                AdrrsJObjct.Get('suite', adrrssTkn);
                ApiConnect.suite := adrrssTkn.AsValue().AsText();
                AdrrsJObjct.Get('city', adrrssTkn);
                ApiConnect.city := adrrssTkn.AsValue().AsText();
                AdrrsJObjct.Get('zipcode', adrrssTkn);
                ApiConnect.ZipCode := adrrssTkn.AsValue().AsCode();
                AdrrsJObjct.Get('geo', adrrssTkn);
                if adrrssTkn.IsObject then begin
                    adrrssTkn.WriteTo(Adrrss);
                    AdrrsJObjct.ReadFrom(Adrrss);
                    AdrrsJObjct.Get('lat', adrrssTkn);
                    ApiConnect.Lat := adrrssTkn.AsValue().AsDecimal();
                    AdrrsJObjct.Get('long', adrrssTkn);
                    ApiConnect.Lat := adrrssTkn.AsValue().AsDecimal();
                end;
            end;


        end;

    end;
}
