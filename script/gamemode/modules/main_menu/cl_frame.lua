F_MAIN_MENU = F_MAIN_MENU or {}


function F_MAIN_MENU:Init()
    local F = FRAMES:SimpleFrame( 1, 1 )
    F:MakePopup()

    local PNL = PANELS:RenderPanel( F, 1, 1, 0, 0 )
end

concommand.Add('FALCON_MENU2', function()
    F_MAIN_MENU:Init()
end)