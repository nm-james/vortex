PANELS = PANELS or {}

function PANELS:SimplePanel( PARENT, w, h, x, y )
    local SW, SH = PARENT:GetSize()
    local P = vgui.Create('DPanel', PARENT)
    P:SetSize( SW * w, SH * h )

    if not x and not y then
        P:Center()
    else
        P:SetPos( SW * x, SH * y )
    end
    return P
end