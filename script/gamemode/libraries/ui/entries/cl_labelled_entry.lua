ENTRIES = ENTRIES or {}

function ENTRIES:LabelledEntry( PARENT, w, h, x, y, LABEL_TEXT, LABEL_FONT )
    local SW, SH = PARENT:GetSize()
    local AREA = PANELS:SimplePanel( PARENT, w, h, x, y )
    local LINE_HEIGHT = ScrH() * 0.0015
    function AREA:Paint( w, h )
        draw.RoundedBox( 0, 0, h * 0.4, w, LINE_HEIGHT, Color(255, 255, 255) )
    end
    local LABEL = TEXTS:SimpleText( AREA, 1, 0.45, 0, 0, LABEL_TEXT or '' )
    LABEL:SetFont(LABEL_FONT or 'F20')
    LABEL:SetContentAlignment( 4 )
    local ENTRY = self:SimpleEntry( AREA, 1, 0.55, 0, 0.45 )

    return AREA, LABEL, ENTRY
end