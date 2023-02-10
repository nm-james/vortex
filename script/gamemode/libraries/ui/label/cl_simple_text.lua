TEXTS = TEXTS or {}

function TEXTS:SimpleText( PARENT, w, h, x, y, TEXT )
    local SW, SH = PARENT:GetSize()
    local D = vgui.Create('DLabel', PARENT)
    D:SetSize( SW * w, SH * h )

    if not x and not y then
        D:Center()
    else
        D:SetPos( SW * x, SH * y )
    end

    D:SetText( TEXT )
    return D
end