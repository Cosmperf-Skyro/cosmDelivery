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


    net.Receive("cosmShop:AfterCheck", function ()
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
            cosmShop.Tool.Name:SetPos(respW(30), respH(100))
            cosmShop.Tool.Name:SetPlaceholderText("Saisir le nom de l'objet")

            cosmShop.Tool.Models = vgui.Create("TLTextEntry", cosmShop.Tool.frame)
            cosmShop.Tool.Models:SetSize(respW(280), respH(40))
            cosmShop.Tool.Models:SetPos(respW(390), respH(100))
            cosmShop.Tool.Models:SetPlaceholderText("Saisir le modèle de l'objet")

            cosmShop.Tool.Price = vgui.Create("TLTextEntry", cosmShop.Tool.frame)
            cosmShop.Tool.Price:SetSize(respW(280), respH(40))
            cosmShop.Tool.Price:SetPos(respW(30), respH(200))
            cosmShop.Tool.Price:SetPlaceholderText("Saisir le prix de l'objet")

            cosmShop.Tool.Class = vgui.Create("TLTextEntry", cosmShop.Tool.frame)
            cosmShop.Tool.Class:SetSize(respW(280), respH(40))
            cosmShop.Tool.Class:SetPos(respW(390), respH(200))
            cosmShop.Tool.Class:SetPlaceholderText("Saisir la classe de l'objet")


            cosmShop.Tool.View = vgui.Create("TLButton", cosmShop.Tool.frame)
            cosmShop.Tool.View:SetSize(respW(300), respH(60))
            cosmShop.Tool.View:SetPos(respW(30), respH(365))
            cosmShop.Tool.View:SetText("Voir les objets")


            cosmShop.Tool.Submit = vgui.Create("TLButton", cosmShop.Tool.frame)
            cosmShop.Tool.Submit:SetSize(respW(300), respH(60))
            cosmShop.Tool.Submit:SetPos(respW(370), respH(365))
            cosmShop.Tool.Submit:SetText("Créer")

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