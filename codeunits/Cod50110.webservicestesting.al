/// <summary>
/// Codeunit webservices testing (ID 50110).
/// </summary>
codeunit 50110 "webservices testing"
{
    local procedure HelloBc() Response: Text
    begin
        Response := 'Hellow from BC!';
    end;
}
