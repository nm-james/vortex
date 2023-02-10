BUTTONS = BUTTONS or {}

function BUTTONS:DockedButton( PARENT, DOCK_DIRECTION, size )
    local SW, SH = PARENT:GetSize()
    local B = vgui.Create('DButton', PARENT)
    B:Dock( DOCK_DIRECTION )

    if DOCK_DIRECTION == TOP or DOCK_DIRECTION == BOTTOM then
        B:SetSize( SW, SH * size )
    elseif DOCK_DIRECTION == LEFT or DOCK_DIRECTION == RIGHT then
        B:SetSize( SW * size, SH )
    end

    
    return B
end