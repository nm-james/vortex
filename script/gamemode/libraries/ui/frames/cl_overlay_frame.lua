FRAMES = FRAMES or {}

function FRAMES:OverylayFrame( PARENT, w, h )
    local F = self:SimpleFrame( w, h )
    PARENT:Hide()
    function F:OnRemove()
        PARENT:Show()
    end
    return F
end