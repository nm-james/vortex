F_ADMIN = F_ADMIN or {}

function F_ADMIN:GetFrame()
    return self._FRAME
end

function F_ADMIN:GetContentPanel()
    return self._CONTENT_PANEL
end

function F_ADMIN:GetNavBar()
    return self._NAV_PANEL
end

function F_ADMIN:Init()
    if not IsValid(self._FRAME) then
        self._FRAME = FRAMES:SimpleFrame( 1, 1 )
        self._CONTENT_PANEL = PANELS:SimplePanel( self._FRAME, 1, 0.95, 0, 0.05 )
        self._CONTENT_PANEL.Paint = nil
        self._NAV_PANEL = PANELS:SimplePanel( self._FRAME, 1, 0.03, 0, 0.02 )
        F_ADMIN.NAVIGATION.ACTIVE_TABS = {}
    end
    local F = self:GetFrame()
    F:Show()
    F:MakePopup()

    self.NAVIGATION:Init()
end

concommand.Add('FALCON_ADMIN', function()
    F_ADMIN:Init()
end)