local function PanelDrawing()
    local RewardsPanel = vgui.Create("DFrame")
    local scrw, scrh = ScrW(), ScrH()
    RewardsPanel:SetPos(scrw * .37, scrh * .30) // So that the panel pops up in the middle of the screen no matter of the resolution
    RewardsPanel:SetSize(800, 800)
    RewardsPanel:SetTitle("")
    RewardsPanel:MakePopup()
    RewardsPanel:ShowCloseButton(false)
        
    function RewardsPanel:Paint(w, h)
        draw.RoundedBox(10, 0, 0, w, h, Color(75, 75, 75))
        draw.RoundedBoxEx(10, 0, 0, w, 40, Color(145, 26, 203), true, true)
    end

    local closepanel = vgui.Create("DImageButton", RewardsPanel)
        closepanel:SetPos(770, 15)
        closepanel:SetSize(20, 20)
        closepanel:SetImage("icon16/cross.png")
        closepanel.DoClick = function()
            RewardsPanel:Close()
        end
        
    local header = vgui.Create("DLabel", RewardsPanel)
    header:SetPos(10, 10)
    header:SetSize(300, 20)
    header:SetColor( Color(255, 255, 255) )
    header:SetText("ToDo translate text")
end

// This is just a "plan" so I can add all the necessary elements in the future