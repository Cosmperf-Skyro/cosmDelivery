TOOL.Category = "COSMPERF"
TOOL.Name = "Shop System"
TOOL.Command = nil 

if CLIENT then
    language.Add("tool.sh_toolshop.name", "Shop Config")
    language.Add("tool.sh_toolshop.desc", "Configurer le système de shop")
    language.Add("tool.sh_toolshop.0", "Clique gauche pour ouvrir le panel")
end

function TOOL:LeftClick()

    net.Start("cosmShop:CheckGroup")
    net.SendToServer()


    net.Receive("cosmDelivery:AfterCheck", function ()
        if not IsValid(cosmShop.Tool.frame) then
            cosmShop.Tool.frame = vgui.Create("TLFrame")
            cosmShop.Tool.frame:SetSize(respW(700), respH(500))
            cosmShop.Tool.frame:Center()
            cosmShop.Tool.frame:ShowCloseButton(true)
            cosmShop.Tool.frame:MakePopup()
            cosmShop.Tool.frame:SetDraggable(false)
            cosmShop.Tool.frame:SetHeader("COSMSHOP | CONFIGURATION")

            cosmShop.Tool.Name = vgui.Create("TLTextEntry", cosmShop.Tool.frame)
            cosmShop.Tool.Name:SetSize(respW(280), respH(40))
            cosmShop.Tool.Name:SetPos(respW(10), respH(100))
            cosmShop.Tool.Name:SetPlaceholderText("Choisir le nom de l'objet")

        end
    end)

end









if SERVER then
    util.AddNetworkString("cosmShop:CheckGroup")
    util.AddNetworkString("cosmShop:AfterCheck")

    net.Receive("cosmShop:CheckGroup", function (len, ply)
        if cosmShop.UserGroup[ply:GetUserGroup()] then
            net.Start("cosmShop:AfterCheck")
            net.Send(ply)
        end
    end)
end