BRANCHES = BRANCHES or {}

local FETCH = F_API.CALL:New()
FETCH:SetURL( F_API:Route('branches', 'id') )
FETCH:SetMethod( 'GET' )

function BRANCHES:Fetch( BRANCHID )
    if BRANCHID then
        FETCH:SetHeaderKey( 'branchid', BRANCHID )
    end
    
    return FETCH:Call()
end