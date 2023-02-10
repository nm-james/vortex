FRAMES = FRAMES or {}

function FRAMES:SimpleFrame( w, h, x, y )
    local SW, SH = ScrW(), ScrH()
    local F = vgui.Create('DFrame')
    F:SetSize( SW * w, SH * h )

    if not x and not y then
        F:Center()
    else
        F:SetPos( SW * x, SH * y )
    end
    return F
end