/// <summary>
/// Codeunit ApiConnect (ID 50102).
/// </summary>
codeunit 50102 ApiConnect
{
    /// <summary>
    /// ApiConnectVal.
    /// </summary>
    /// <param name="ApiConnect">Record ApiConnect.</param>
    //[TryFunction]
    procedure ApiConnectVal(var ApiConnect: Record ApiConnect)
    var
        Client: HttpClient;
        response: HttpResponseMessage;
        OutPut: Text;
        APIjsonObj: JsonObject;
        jsonTkn: JsonToken;
        Adrssjsonobj: JsonObject;
        adrssjsotkn: JsonToken;
        result: Text;

    begin
        if Client.Get('https://jsonplaceholder.typicode.com/users/' + Format(ApiConnect.UserId), response) then
            response.Content().ReadAs(OutPut)
        else
            Error('No data of such record present');
        APIjsonObj.ReadFrom(OutPut);
        APIjsonObj.Get('name', jsonTkn);
        ApiConnect.Name := jsonTkn.AsValue().AsText();
        APIjsonObj.Get('username', jsonTkn);
        ApiConnect.UserName := jsonTkn.AsValue().AsText();
        APIjsonObj.Get('email', jsonTkn);
        ApiConnect.email := jsonTkn.AsValue().AsText();
        APIjsonObj.Get('phone', jsonTkn);
        ApiConnect.Phone := jsonTkn.AsValue().AsCode();
        APIjsonObj.Get('website', jsonTkn);
        ApiConnect.website := jsonTkn.AsValue().AsText();
        APIjsonObj.Get('address', jsonTkn);
        jsonTkn.WriteTo(result);
        if jsonTkn.IsObject then begin
            Adrssjsonobj.ReadFrom(result);
            Adrssjsonobj.Get('street', adrssjsotkn);
            ApiConnect.Street := adrssjsotkn.AsValue().AsText();
            Adrssjsonobj.Get('suite', adrssjsotkn);
            ApiConnect.suite := adrssjsotkn.AsValue().AsText();

        end;
    end;
    var
    v: Codeunit Regex;
}
