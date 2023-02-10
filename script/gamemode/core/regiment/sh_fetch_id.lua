REGIMENTS = REGIMENTS or {}

local FETCH = F_API.CALL:New()
FETCH:SetURL( F_API:Route('regiments', 'id') )
FETCH:SetMethod( 'GET' )

function REGIMENTS:Fetch( REG_ID )
    if REG_ID then
        FETCH:SetHeaderKey( 'regid', REG_ID )
    end
    
    return FETCH:Call()
end