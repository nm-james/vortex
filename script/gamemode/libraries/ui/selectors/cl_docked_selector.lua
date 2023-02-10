SELECTORS = SELECTORS or {}

function SELECTORS:DockedSelector( PARENT, DOCK_DIRECTION, size, OPTIONS )
    local SW, SH = PARENT:GetSize()
    local S = vgui.Create('DComboBox', PARENT)
    S:Dock( DOCK_DIRECTION )

    if DOCK_DIRECTION == TOP or DOCK_DIRECTION == BOTTOM then
        S:SetSize( SW, SH * size )
    elseif DOCK_DIRECTION == LEFT or DOCK_DIRECTION == RIGHT then
        S:SetSize( SW * size, SH )
    end

    for _, choice in ipairs( OPTIONS ) do
        S:AddChoice( choice )
    end

    return S
end