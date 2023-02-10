// FALCON - PLAYER CONNECT - DATA
util.AddNetworkString('F:PC:D')

net.Receive('F:PC:D', function( _, ply )
    local USER_ID = USERS:Fetch( ply )
    USER_ID:SetCallback( function( result )
        local result_transformed = util.JSONToTable( result )
        if not result_transformed.id then return end
        ply:SetAPIID( result_transformed.id )
    end )

    USER_ID:SetCatch( function( test )
        USER_ID = USERS:Create( ply )
        USER_ID:SetCallback( function( result )
            local result_transformed = util.JSONToTable( result )
            if not result_transformed.id then return end
            ply:SetAPIID( result_transformed.id )
        end )
    end )


   
    -- net.Start('F:PC:D')
    -- net.Send( ply )
end)