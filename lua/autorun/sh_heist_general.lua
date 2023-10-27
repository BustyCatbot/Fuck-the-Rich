AddCSLuaFile()

properties.Add( "connect", {
    MenuLabel = "Connect",
    Type = "simple",
    Order = 0,
    MenuIcon = "icon16/plugin_link.png",
    Filter = function(self, ent, ply)

        if !IsValid( ent ) then return false end
        if ( !gamemode.Call( "CanProperty", ply, "connect", ent ) ) then return false end
        if !string.StartsWith( ent:GetClass(), "heist_" ) then return false end

        return true

    end,
    Action = function(self, ent, tr)

        net.Start("HeistEventConnect")
            net.WriteEntity(ent)
        net.SendToServer()
    
    end,
} )