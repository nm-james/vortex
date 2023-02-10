SELECTORS = SELECTORS or {}

function SELECTORS:SimpleSelector( PARENT, w, h, x, y, OPTIONS )
    local SW, SH = PARENT:GetSize()
    local S = vgui.Create('DComboBox', PARENT)
    S:SetSize( SW * w, SH * h )

    if not x and not y then
        S:Center()
    else
        S:SetPos( SW * x, SH * y )
    end

    for _, choice in ipairs( OPTIONS or {} ) do
        S:AddChoice( choice )
    end


    return S
end