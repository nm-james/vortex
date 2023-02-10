ENTRIES = ENTRIES or {}

function ENTRIES:SimpleEntry( PARENT, w, h, x, y )
    local SW, SH = PARENT:GetSize()
    local F = vgui.Create('DTextEntry', PARENT)
    F:SetSize( SW * w, SH * h )

    if not x and not y then
        F:Center()
    else
        F:SetPos( SW * x, SH * y )
    end
    return F
end