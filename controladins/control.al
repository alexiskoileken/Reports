/// <summary>
/// ControlAddIn EveryDayNewThingDynamic.
/// </summary>
controladdin EveryDayNewThingDynamic
{
    RequestedHeight = 300;
    MinimumHeight = 300;
    MaximumHeight = 300;
    RequestedWidth = 700;
    MinimumWidth = 700;
    MaximumWidth = 700;
    VerticalStretch = true;
    VerticalShrink = true;
    HorizontalStretch = true;
    HorizontalShrink = true;
    StartupScript = 'js/Adin.js';
    Images =
        'images/Amazon.webp';
    event CustomProcedure()

    procedure MyProcedure()
}