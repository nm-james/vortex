F_API = {}
F_API.HOST = "gmod.api.dev"
F_API.PORT = 3690

function F_API:HostDomain()
    return 'http://' .. self.HOST .. ":" .. self.PORT
end

function F_API:Route(...)
    local args = {...}
    local ROUTE = F_API:HostDomain()
    for i, v in ipairs(args) do
        ROUTE = ROUTE .. '/' .. v
    end
    return ROUTE
end



F_API.CALL = {}
F_API.CALL.__index = F_API.CALL

function F_API.CALL:SetURL( route )
    self._URL = route
end

function F_API.CALL:SetBodyKey( bodyKey, bodyValue )
    self._BODY[bodyKey] = bodyValue
end

function F_API.CALL:SetHeaderKey( headerKey, headerValue )
    self._HEADERS[headerKey] = headerValue
end

function F_API.CALL:SetMethod( typeOfAPI )
    self._API_TYPE = typeOfAPI
end

function F_API.CALL:GetMethod()
    return self._API_TYPE
end


// If the API call returns an empty json string, then declare it as fail
function F_API.CALL:SetEmptyFailure( isFailure )
    self._EMPTY_FAIL = isFailure
end


function F_API.CALL:Call()
    local TYPE_API = self:GetMethod()
    local new_Promise = PROMISE:New()
    local success = function( data, ... )
        if self._EMPTY_FAIL and (data == "{}" or data == "[]") then
            return new_Promise:FailSafe( data, ... )
        end
        return new_Promise:Resolve( data, ... )
    end

    local failed = function( ... )
        return new_Promise:FailSafe( ... )
    end

    if TYPE_API ~= 'POST' then
        http.Fetch( self._URL,
            success,
            failed,
            self._HEADERS
        )
    else
        http.Post( self._URL, self._BODY,
            success,
            failed,
            self._HEADERS
        )
    end

    self._BODY = {}
    self._HEADERS = {}

    return new_Promise
end

function F_API.CALL:New()
    local NEW_CALL = {}
    NEW_CALL._URL = F_API:HostDomain()
    NEW_CALL._BODY = {}
    NEW_CALL._HEADERS = {}
    NEW_CALL._API_TYPE = "GET"
    NEW_CALL._EMPTY_FAIL = false


    setmetatable( NEW_CALL, self )
    return NEW_CALL
end