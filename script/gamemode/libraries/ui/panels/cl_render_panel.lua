PANELS = PANELS or {}

function PANELS:RenderPanel( PARENT, w, h, x, y )
    local P = PANELS:SimplePanel( PARENT, w, h, x, y )
    local vector_zero = Vector()
    function P:GetRenderPos()
        return self._Pos or vector_zero
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
    local p_x, p_y = P:GetParent():GetParent():GetPos()

    function P:Paint( w, h )
        local old = DisableClipping( true )
        render.RenderView( {
            x = p_x,
            y = p_y,
            w = w,
            h = h,
            pos = self:GetRenderPos(),
            ang = self:GetRenderAngle()
        } )
        DisableClipping( old )
    end

    return P
end