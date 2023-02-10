PANELS = PANELS or {}

function PANELS:LoaderPanel( PARENT, w, h, x, y )
    local SW, SH = PARENT:GetSize()
    local CONTENT = self:SimplePanel( PARENT, w, h, x, y )
    CONTENT:Hide()
    local LOADER = self:SimplePanel( PARENT, w, h, x, y )
    function LOADER:Paint( w, h )
        draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 155 ))
    end
    function CONTENT:FinishLoad()
        LOADER:Remove()
        CONTENT:Show()
    end
    return CONTENT
end