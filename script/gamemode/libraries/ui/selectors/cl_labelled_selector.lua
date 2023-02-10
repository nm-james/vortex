SELECTORS = SELECTORS or {}

function SELECTORS:LabelledSelector( PARENT, w, h, x, y, OPTIONS, LABEL_TEXT, LABEL_FONT )
    local SW, SH = PARENT:GetSize()
    local AREA = PANELS:SimplePanel( PARENT, w, h, x, y )
    local LINE_HEIGHT = ScrH() * 0.0015
    function AREA:Paint( w, h )
        draw.RoundedBox( 0, 0, h * 0.4, w, LINE_HEIGHT, Color(255, 255, 255) )
    end
    local LABEL = TEXTS:SimpleText( AREA, 1, 0.45, 0, 0, LABEL_TEXT or '' )
    LABEL:SetFont(LABEL_FONT or 'F20')
    LABEL:SetContentAlignment( 4 )
    local SELECTOR = self:SimpleSelector( AREA, 1, 0.55, 0, 0.45, OPTIONS )

    return AREA, LABEL, SELECTOR
end