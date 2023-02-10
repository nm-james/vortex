BUTTONS = BUTTONS or {}

function BUTTONS:SimpleButton( PARENT, w, h, x, y )
    local SW, SH = PARENT:GetSize()
    local B = vgui.Create('DButton', PARENT)
    B:SetSize( SW * w, SH * h )
    if not x and not y then
        B:Center()
    else
        B:SetPos( SW * x, SH * y )
    end

    return B
end