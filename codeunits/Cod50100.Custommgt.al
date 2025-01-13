/// <summary>
/// Codeunit Custom mgt  (ID 50100) implements Interface IAdressProvider.
/// </summary>
codeunit 50100 "Custom mgt " implements IAdressProvider
{
    /// <summary>
    /// GetAdress.
    /// </summary>
    /// <returns>Return value of type Text.</returns>
    procedure GetAdress(): Text
    var
        CompInfo: Record "Company Information";
    begin
        CompInfo.Reset();
        CompInfo.SetCurrentKey(Address);
        if CompInfo.FindFirst() then
            exit(StrSubstNo('the address is %1', compinfo.Address))
    end;
    //codes for perfoming multiple requests
    local procedure MyProcedure()
    var
        client: HttpClient;
        HttpResponseMessage: HttpResponseMessage;
    begin
        client.SetBaseAddress('https://jsonplaceholder.typicode.com/');
        client.Get('Posts', HttpResponseMessage)
    end;

}
