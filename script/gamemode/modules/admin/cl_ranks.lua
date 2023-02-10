F_ADMIN = F_ADMIN or {}
F_ADMIN.RANKS = F_ADMIN.RANKS or {}
F_ADMIN.RANKS.API = F_ADMIN.RANKS.API or {}


function F_ADMIN.RANKS.API:GetBranches( BRANCH_ID )
    return BRANCHES:Fetch( BRANCH_ID )
end

function F_ADMIN.RANKS:FailedToLoad( DATA )
    
end

function F_ADMIN.RANKS:GetSideBar()
    return self._SIDE_BAR
end

function F_ADMIN.RANKS:SetSideBar( PNL )
    self._SIDE_BAR = PNL
end

function F_ADMIN.RANKS:GetContentPanel()
    return self._CONTENT_BAR
end

function F_ADMIN.RANKS:SetContentPanel( PNL )
    self._CONTENT_BAR = PNL
end

function F_ADMIN.RANKS:CreateNewBranchUI()
    local MAIN = F_ADMIN:GetFrame()
    local F = FRAMES:SimpleFrame( 0.25, 0.15 )
    F:MakePopup()

    local _, _, NAME = ENTRIES:LabelledEntry( F, 0.9, 0.4, 0.05, 0.2, 'NAME', 'F18' )
    local CONFIRM = BUTTONS:SimpleButton( F, 0.9, 0.2, 0.05, 0.62 )
    CONFIRM:SetText('CREATE')
    function CONFIRM:DoClick()
        local NAME_VALUE = NAME:GetValue()
        local BRANCH_PROMISE = BRANCHES:Create( NAME_VALUE )
        F_ADMIN:GetContentPanel():Clear()
        F:Close()

        BRANCH_PROMISE:SetCallback( function()
            F_ADMIN.RANKS:Init()
        end )
    end
end



function F_ADMIN.RANKS:LoadBranchData( BRANCHID )
    local REGIMENT_SIDEBAR = PANELS:LoaderPanel( CONTENT, 0.2, 1, 0, 0 )
    local REG_DATA_PROMISE = self.API:GetRegimentData( REGID )

    REG_DATA_PROMISE:SetCallback( function( DATA )
    end )
end

function F_ADMIN.RANKS:LoadSideBar( DATA )
    local CONTENT = self:GetSideBar()
    local ADD_BRANCH_BTN = BUTTONS:DockedButton( CONTENT, TOP, 0.04 )
    ADD_BRANCH_BTN:SetText('CREATE')
    function ADD_BRANCH_BTN:DoClick()
        F_ADMIN.RANKS:CreateNewBranchUI()
    end

    for _, branchDATA in pairs( DATA ) do
        local BTN = BUTTONS:DockedButton( CONTENT, TOP, 0.04 )
        function BTN:DoClick()
            if IsValid( F_ADMIN.RANKS:GetContentPanel() ) then
                F_ADMIN.RANKS:GetContentPanel():Remove()
            end
            F_ADMIN.RANKS:LoadBranchData( branchDATA.id )
        end
    end 
end


function F_ADMIN.RANKS:Init( CONTENT )
    local CONTENT = CONTENT or F_ADMIN:GetContentPanel()

    local REGIMENT_SIDEBAR = PANELS:LoaderPanel( CONTENT, 0.2, 1, 0, 0 )
    self:SetSideBar( REGIMENT_SIDEBAR )
    local REG_PROMISE = self.API:GetBranches()

    REG_PROMISE:SetCallback( function( DATA )
        REGIMENT_SIDEBAR:FinishLoad()
        self:LoadSideBar( util.JSONToTable(DATA) )
    end )

    REG_PROMISE:SetCatch( function(err)
    end )
end