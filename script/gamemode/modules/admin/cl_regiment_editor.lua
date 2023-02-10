F_ADMIN = F_ADMIN or {}
F_ADMIN.REGIMENTS = {}
F_ADMIN.REGIMENTS.API = {}


function F_ADMIN.REGIMENTS.API:GetRegiment( REGID )
    return REGIMENTS:Fetch( REGID )
end


function F_ADMIN.REGIMENTS.API:GetBranches()
    return BRANCHES:Fetch()
end

function F_ADMIN.REGIMENTS:FailedToLoad( DATA )
    
end

function F_ADMIN.REGIMENTS:GetSideBar()
    return self._SIDE_BAR
end

function F_ADMIN.REGIMENTS:SetSideBar( PNL )
    self._SIDE_BAR = PNL
end

function F_ADMIN.REGIMENTS:GetContentPanel()
    return self._CONTENT_BAR
end

function F_ADMIN.REGIMENTS:SetContentPanel( PNL )
    self._CONTENT_BAR = PNL
end

function F_ADMIN.REGIMENTS:CreateNewRegimentUI()
    local MAIN = F_ADMIN:GetFrame()
    local F = FRAMES:SimpleFrame( 0.25, 0.25 )
    F:MakePopup()
    local REGIMENT_SIDEBAR = PANELS:LoaderPanel( F, 1, 0.94, 0, 0.06 )
    REGIMENT_SIDEBAR.Paint = nil

    local _, _, NAME = ENTRIES:LabelledEntry( REGIMENT_SIDEBAR, 0.9, 0.25, 0.05, 0.1, 'NAME', 'F15' )
    local CONFIRM = BUTTONS:SimpleButton( REGIMENT_SIDEBAR, 0.9, 0.125, 0.05, 0.665, 'NAME', 'F15' )
    CONFIRM:SetText('CONFIRM')

    local BRANCHES_PROMISE = self.API:GetBranches()
    BRANCHES_PROMISE:SetCallback( function( DATA )
        local TABLE_DATA = util.JSONToTable( DATA )
        local _, _, BRANCHES_SELECTOR = SELECTORS:LabelledSelector( REGIMENT_SIDEBAR, 0.9, 0.25, 0.05, 0.4, {}, 'BRANCH', 'F15' )
        function BRANCHES_SELECTOR:OnSelect( _, _, CHOICE_DATA )
            self._ACTIVE_ID = CHOICE_DATA.id
        end
        for _, branchesDATA in ipairs( TABLE_DATA ) do
            BRANCHES_SELECTOR:AddChoice( branchesDATA.name, branchesDATA )
        end
        function CONFIRM:DoClick()
            if BRANCHES_SELECTOR:GetValue() == "" then return end
            local REG_PROMISE = REGIMENTS:Create( NAME:GetValue(), BRANCHES_SELECTOR._ACTIVE_ID )
            F_ADMIN:GetContentPanel():Clear()
            F:Close()
            REG_PROMISE:SetCallback( function()
                F_ADMIN.REGIMENTS:Init()
            end )
        end
        REGIMENT_SIDEBAR:FinishLoad()
    end )
    
end

function F_ADMIN.REGIMENTS:LoadRegiment()

end

function F_ADMIN.REGIMENTS:LoadRegiments( REG_DATA )
    local REG_DATA = REG_DATA or {}
    local CONTENT = self:GetContentPanel()

    local LEFT_REG = BUTTONS:SimpleButton( CONTENT, 0.05, 0.3, 0.01, 0.35 )
    local RIGHT_REG = BUTTONS:SimpleButton( CONTENT, 0.05, 0.3, 0.94, 0.35 )
end

function F_ADMIN.REGIMENTS:Init( CONTENT )
    local CONTENT = CONTENT or F_ADMIN:GetContentPanel()
    local RENDER = PANELS:RenderPanel( CONTENT, 1, 1, 0, 0 )
    local LOADER_PANEL = PANELS:LoaderPanel( RENDER, 1, 1, 0, 0 )
    LOADER_PANEL.Paint = nil
    self:SetContentPanel( LOADER_PANEL )

    local CREATE = BUTTONS:SimpleButton( CONTENT, 0.02, 0.04, 0.97, 0.02 )
    CREATE:SetText('+')
    function CREATE:DoClick()
        F_ADMIN.REGIMENTS:CreateNewRegimentUI()
    end

    local REGIMENT_DATA = self.API:GetRegiment()
    REGIMENT_DATA:SetCallback( function( DATA ) 
        LOADER_PANEL:FinishLoad()
        F_ADMIN.REGIMENTS:LoadRegiments( DATA )
    end )
end