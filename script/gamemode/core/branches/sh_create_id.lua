BRANCHES = BRANCHES or {}

local CREATE = F_API.CALL:New()
CREATE:SetURL( F_API:Route('branches', 'create') )
CREATE:SetMethod( 'POST' )

function BRANCHES:Create( BRANCH_NAME )
    CREATE:SetBodyKey( 'name', BRANCH_NAME )
    
    return CREATE:Call()
end