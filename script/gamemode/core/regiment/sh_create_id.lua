REGIMENTS = REGIMENTS or {}

local CREATE = F_API.CALL:New()
CREATE:SetURL( F_API:Route('regiments', 'create') )
CREATE:SetMethod( 'POST' )

local COLOR = '{"r":255.0,"b":255.0,"g":255.0}'
local VECTOR_JSON = '{"x": 0.0, "y": 0.0, "z": 0.0}'

function REGIMENTS:Create( REGIMENT_NAME, BRANCH_ID )
    CREATE:SetBodyKey( 'name', REGIMENT_NAME )
    CREATE:SetBodyKey( 'branch', BRANCH_ID )
    CREATE:SetBodyKey( 'color', COLOR )
    CREATE:SetBodyKey( 'creationView', VECTOR_JSON )


    
    return CREATE:Call()
end