USERS = USERS or {}

local FETCH = F_API.CALL:New()
FETCH:SetURL( F_API:Route('users', 'steam') )
FETCH:SetMethod( 'GET' )
FETCH:SetEmptyFailure( true )


function USERS:Fetch( ply )
    FETCH:SetHeaderKey( 'steamID', ply:SteamID64() )
    return FETCH:Call()
end