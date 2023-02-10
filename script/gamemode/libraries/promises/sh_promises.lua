PROMISE = {}
PROMISE.__index = PROMISE

function PROMISE:SetCallback( f )
    self._OnResolveCallback = f
end

function PROMISE:GetCallback()
    return self._OnResolveCallback or function() end
end

function PROMISE:SetCatch( f )
    self._OnErrorCallback = f
end

function PROMISE:GetCatch()
    return self._OnErrorCallback or function() end
end


function PROMISE:Resolve(...)
    return self:GetCallback()( ... )
end

function PROMISE:FailSafe(...)
    return self:GetCatch()( ... )
end


function PROMISE:New()
    local NEW_PROMISE = {}
    NEW_PROMISE._OnResolveCallback = function() end
    NEW_PROMISE._OnErrorCallback = function() end

    setmetatable( NEW_PROMISE, self )

    return NEW_PROMISE
end