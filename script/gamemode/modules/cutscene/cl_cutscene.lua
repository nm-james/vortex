CUTSCENE = CUTSCENE or {}

function CUTSCENE:GetPhase()
    return self._PHASE
end

function CUTSCENE:SetPhase( PHASE )
    self._PHASE = PHASE
end

function CUTSCENE:Lerp()

end

function CUTSCENE:GetID()

end

function CUTSCENE:Play( CUTSCENE_ID )
end


CUTSCENE.TEMPLATE = {}
CUTSCENE.TEMPLATE.__index = CUTSCENE.TEMPLATE

function CUTSCENE.TEMPLATE:NewPhase()

end

function CUTSCENE.TEMPLATE:RegisterCharacter()

end

function CUTSCENE.TEMPLATE:SetCharacterPhasePos()


end

function CUTSCENE.TEMPLATE:SetCharacterPhaseMovePos()

end

function CUTSCENE.TEMPLATE:SetCharacterPhaseAngle()

end

function CUTSCENE.TEMPLATE:SetCharacterPhaseMoveAngle()

end
