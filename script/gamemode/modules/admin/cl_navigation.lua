F_ADMIN = F_ADMIN or {}
F_ADMIN.NAVIGATION = F_ADMIN.NAVIGATION or {}
F_ADMIN.NAVIGATION.ACTIVE_TABS = F_ADMIN.NAVIGATION.ACTIVE_TABS or {}
function F_ADMIN.NAVIGATION:SetActiveTab( TAB_ID )
    self._TAB_ID = TAB_ID
    for tabID, contentPNL in pairs(self.ACTIVE_TABS) do
        if TAB_ID == tabID then contentPNL:Show() continue end
        contentPNL:Hide()
    end
end

function F_ADMIN.NAVIGATION:GetActiveTab( TAB_ID )
    return self._TAB_ID or -1
end


function F_ADMIN.NAVIGATION:CreateTab( TAB_TYPE )
    local CONTENT = F_ADMIN:GetContentPanel()

    local CONTENT_COPY = PANELS:SimplePanel( CONTENT, 1, 1, 0, 0 )
    F_ADMIN[TAB_TYPE]:Init( CONTENT_COPY )

    self.ACTIVE_TABS[ #self.ACTIVE_TABS + 1 ] = CONTENT_COPY

    self:SetActiveTab( #self.ACTIVE_TABS )
end

function F_ADMIN.NAVIGATION:Init()
    local CONTENT = F_ADMIN:GetNavBar()
    CONTENT:Clear()

    for tabID, contentPNL in pairs(F_ADMIN.NAVIGATION.ACTIVE_TABS) do
        local BTN = BUTTONS:DockedButton( CONTENT, LEFT, 0.05 )
        function BTN:Paint( w, h )
            draw.RoundedBox( 0, 0, 0, w, h, Color(0, 0, 0, 155) )
        end
        function BTN:DoClick()
            F_ADMIN.NAVIGATION:SetActiveTab( tabID )
        end
    end
    
    local ADD_TAB = SELECTORS:DockedSelector( CONTENT, LEFT, 0.0175, { "REGIMENTS", "STATISTICS", "RANKS" } )
    ADD_TAB:SetValue( '+' )
    function ADD_TAB:OnSelect( _, VARIANT )
        F_ADMIN.NAVIGATION:CreateTab( VARIANT )
        F_ADMIN.NAVIGATION:Init()
    end
end