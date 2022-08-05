TOOL.Category = "COSMPERF"
TOOL.Name = "Delivery System"
TOOL.Command = nil 

if CLIENT then
    language.Add("tool.sh_tooldelivery.name", "Delivery Config")
    language.Add("tool.sh_tooldelivery.desc", "Configurer le système de livraison")
    language.Add("tool.sh_tooldelivery.0", "Clique gauche pour ouvrir le panel")
end

function TOOL:LeftClick()

    net.Start("cosmDelivery:CheckGroup")
    net.SendToServer()


    net.Receive("cosmDelivery:AfterCheck", function ()
        //if not IsValid(cosmDelivery.Tool.frame) then
            local frame = vgui.Create("DFrame")
            frame:SetSize(1000, 500)
            frame:Center()
       // end
    end)

end








if SERVER then
    util.AddNetworkString("cosmDelivery:CheckGroup")
    util.AddNetworkString("cosmDelivery:AfterCheck")

    net.Receive("cosmDelivery:CheckGroup", function (len, ply)
        if cosmDelivery.UserGroup[ply:GetUserGroup()] then
            net.Start("cosmDelivery:AfterCheck")
            net.Send(ply)
        end
    end)
end