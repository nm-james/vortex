USERS = USERS or {}

local CREATE = F_API.CALL:New()
CREATE:SetURL( F_API:Route('users', 'create') )
CREATE:SetMethod( 'POST' )

function USERS:Create( ply )
    CREATE:SetBodyKey( "steamID", ply:SteamID64() )
    return CREATE:Call()
end