PANELS = PANELS or {}

function PANELS:SceneLoaderPanel( PARENT, w, h, x, y )
    local P = PANELS:SimplePanel( PARENT, w, h, x, y )
    function P:GetRenderPos()
        return self._Pos or Vector()
    end
    function P:SetRenderPos( pos )
        self._Pos = pos
    end
    function P:SetRenderAngle( ang )
        self._Ang = ang
    end
    function P:GetRenderAngle()
        return self._Ang
    end

    function P:Paint( w, h )
        local x, y = self:GetPos()
        render.RenderView( {
            x = x,
            y = y,
            w = w,
            h = h,
            pos = self:GetRenderPos(),
            ang = self:GetRenderAngle()
        } )
    end

    return P
end