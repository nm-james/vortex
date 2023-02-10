local ply = FindMetaTable( 'Player' )

function ply:SetAPIID( id )
    self:SetNWString('FALCON:APIID', id)
end

function ply:SendUserCharacters()

end