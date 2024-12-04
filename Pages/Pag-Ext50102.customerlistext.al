pageextension 50102 "customer list ext" extends "Customer List"
{
    layout
    {
        addafter(Name)
        {
            field("Customer State"; Rec."Customer State")
            {

            }
        }
    }
}
