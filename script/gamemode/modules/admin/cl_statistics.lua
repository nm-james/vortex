F_ADMIN = F_ADMIN or {}
F_ADMIN.STATISTICS = {}
function F_ADMIN.STATISTICS:Init( CONTENT )
    local CONTENT = CONTENT or F_ADMIN:GetContentPanel()

    local REGIMENT_SIDEBAR = PANELS:SimplePanel( CONTENT, 0.9, 0.03, 0.05, 0 )
    
end