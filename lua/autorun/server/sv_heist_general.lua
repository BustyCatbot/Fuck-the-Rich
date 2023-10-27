AddCSLuaFile()
util.AddNetworkString( "HeistEventConnect" )
util.AddNetworkString( "HeistRegisterEntity" )

CreateConVar("sv_heist_editor", 0, FCVAR_CHEAT, "", 0, 1)
CreateConVar("sv_heist_lobby", 0, FCVAR_CHEAT, "", 0, 1)
CreateConVar("sv_heist_gamestate", 0, FCVAR_CHEAT, "", -3, 3)

if engine.ActiveGamemode() == "heist" then

    heistdefaultpreset = {
        settings = {},
        activator = {
            ["Base"] = {
                name = "Activator",
                model = "models/hunter/blocks/cube025x025x025.mdl",
                icon = "",
                action = "Activate",
                type = "object",
                enabled = false,
                active = false,
                consume = false,
                requiredequipment = "",
                usetime = 1,
                usetext = "Activate",
                usingtext = "Activating",
                startsound = "buttons/button14.wav",
                usingsound = "ambient/machines/combine_terminal_loop1.wav",
                canceledsound = "buttons/button19.wav",
                usedsound = "buttons/button3.wav",
            },
            ["Lockpick"] = {
                name = "Lockpick",
                model = "models/hunter/blocks/cube025x025x025.mdl",
                icon = "icon16/lock_open.png",
                action = "Lockpick",
                type = "interaction",
                enabled = true,
                active = true,
                consume = true,
                requiredequipment = "",
                usetime = 3,
                usetext = "Lockpick",
                usingtext = "Lockpicking",
                startsound = "doors/door_locked2.wav",
                usingsound = "",
                canceledsound = "doors/latchlocked2.wav",
                usedsound = "doors/latchunlocked1.wav",
            },
        },
        deployable = {
            ["Base"] = {
                name = "Deployable",
                model = "models/hunter/blocks/cube025x025x025.mdl",
                action = "Use",
                icon = "",
                stack = 1,
                dropsound = "",
            },
        },
        equipment = {
            ["Base"] = {
                name = "Equipment",
                model = "models/hunter/blocks/cube025x025x025.mdl",
                action = "Take",
                icon = "",
                requiredequipment = "",
                stack = 1,
                takesound = "",
                consumed = false,
            },
        },
        event = {
            ["Base"] = {
                name = "Event",
                icon = "icon16/color_wheel.png",
                action = "Remove",
                input = false,
                output = "remove",
            },
            ["Relay"] = {
                name = "Relay",
                icon = "icon16/chart_organisation.png",
                action = "Relay",
                input = true,
                output = "relay",
            },
            ["Enable"] = {
                name = "Enable",
                icon = "icon16/tick.png",
                action = "Enable",
                input = true,
                output = "enable",
            },
            ["Disable"] = {
                name = "Disable",
                icon = "icon16/cross.png",
                action = "Disable",
                input = true,
                output = "disable",
            },
            ["Activate"] = {
                name = "Activate",
                icon = "icon16/add.png",
                action = "Activate",
                input = true,
                output = "activate",
            },
            ["Deactivate"] = {
                name = "Deactivate",
                icon = "icon16/delete.png",
                action = "Deactivate",
                input = true,
                output = "deactivate",
            },
            ["Remove"] = {
                name = "Remove",
                icon = "icon16/delete.png",
                action = "Remove",
                input = true,
                output = "remove",
            },
            ["UnlockDoor"] = {
                name = "Unlock Door",
                icon = "icon16/lock_open.png",
                action = "Unlock",
                input = false,
                output = "unlockdoor",
            },
        },
        loot = {
            ["Base"] = {
                name = "Loot",
                model = "models/hunter/blocks/cube025x025x025.mdl",
                icon = "",
                action = "Take",
                requiredequipment = "",
                usetime = 1,
                usetext = "Bag the Loot",
                startsound = "",
                usingsound = "",
                canceledsound = "",
                usedsound = "",
                resultloot = "Base",
            },
        },
        objective = {
            ["Base"] = {
                name = "Objective",
                model = "models/hunter/blocks/cube025x025x025.mdl",
                icon = "",
                action = "Place",
                requiredequipment = "",
                placetime = 1,
                placetext = "Place the Objective",
                startplacesound = "",
                placingsound = "",
                canceledplacesound = "",
                placedsound = "",
                fixtime = 1,
                fixtext = "Fix the Objective",
                startfixsound = "",
                fixingsound = "",
                canceledfixsound = "",
                fixedsound = "",
            },
        },
        spawner = {
            ["Base"] = {
                name = "Spawner",
                icon = "",
                action = "Spawn",
            },
        },
        zone = {
            ["Base"] = {
                name = "Zone",
                icon = "",
                action = "Trigger",
            },
        },
    }

    if !file.IsDir("Heist/Presets/Default", "DATA") then
        file.CreateDir("Heist/Presets/Default")
    end

    for k,v in pairs(heistdefaultpreset) do

        file.Write("Heist/Presets/Default/"..k..".txt", util.TableToJSON(v, true))

    end

    heistsettings = {
        preset = "Default",
    }

    function HeistLoadPreset(preset, type)

        return util.JSONToTable(file.Read("Heist/Presets/"..preset.."/"..type..".txt", "DATA"))

    end

    function HeistGetObject(type, object)

        return HeistLoadPreset(heistsettings.preset, type)[object]

    end

    net.Receive("HeistEventConnect", function(len, ply)

        local ent = net.ReadEntity()

        if IsValid(ply:GetNWEntity("HeistInputEvent", nil)) then

            if ply:GetNWEntity("HeistInputEvent") == ent then

                ent:EmitSound( "buttons/button16.wav", 75, 100, 1 )
                ply:SetNWEntity("HeistInputEvent", ply)

            elseif ply:GetNWEntity("HeistInputEvent") == ply then

                ent:EmitSound( "buttons/button17.wav", 75, 100, 1 )
                ply:SetNWEntity("HeistInputEvent", ent)

            else

                if table.HasValue(ply:GetNWEntity("HeistInputEvent").outputobjects, ent:GetNWString("HeistInstanceID")) then

                    ent:EmitSound( "buttons/button16.wav", 75, 100, 1 )
                    ply:GetNWEntity("HeistInputEvent")["outputobjects"][table.KeyFromValue( ply:GetNWEntity("HeistInputEvent")["outputobjects"], ent:GetNWString("HeistInstanceID") )] = nil

                elseif table.HasValue(ent.outputobjects, ply:GetNWEntity("HeistInputEvent"):GetNWString("HeistInstanceID")) or (ent.ObjectType != "event" and ply:GetNWEntity("HeistInputEvent").ObjectType != "event") then

                    ent:EmitSound( "buttons/button18.wav", 75, 100, 1 )

                else

                    ent:EmitSound( "buttons/button9.wav", 75, 100, 1 )
                    table.insert( ply:GetNWEntity("HeistInputEvent").outputobjects, ent:GetNWString("HeistInstanceID") )

                end
                
                print(table.ToString(ply:GetNWEntity("HeistInputEvent").outputobjects, "", true))
                ply:SetNWEntity("HeistInputEvent", ply)

            end

        else

            ply:SetNWEntity("HeistInputEvent", ply)

        end

    end)

end

hook.Add( "Initialize", "HeistObjectInit", function()

    if engine.ActiveGamemode() == "heist" then

        local objects = {
            "Activator",
            "Deployable",
            "Equipment",
            "Event",
            "Loot",
            "Spawner",
            "Zone",
        }

        print("[FtR]    Initializing Objects")

        for k,v in pairs(objects) do

            local objecttype = v

            print("[FtR]        Initializing "..v.." Objects")

            for k,v in pairs(HeistLoadPreset(heistsettings.preset, string.lower(objecttype))) do

                if k != "Base" then

                    print("[FtR]            Initializing "..objecttype.." : "..v["name"].." ["..k.."]")

                    local ent = {}

                    ent.ObjectType = string.lower(objecttype)

                    ent.Type = "anim"
                    ent.Base = "heist_"..string.lower(objecttype).."_base"

                    ent.PrintName = v["name"]
                    ent.Category = "Heist "..objecttype
                    ent.Author = "Catbot Studios"

                    ent.Spawnable = true
                    ent.Object = k

                    scripted_ents.Register( ent, "heist_"..ent.ObjectType.."_"..string.lower(k) )

                    print("[FtR]                "..scripted_ents.GetMember( "heist_"..ent.ObjectType.."_"..string.lower(k), "PrintName" ).." Initialized")

                end

            end

        end

    end

end )

hook.Add( "PlayerInitialSpawn", "HeistPlayerInit", function( ply )
    
    for k,v in pairs(scripted_ents.GetList()) do

        if string.StartWith(v.t.ClassName, "heist_") then

            if v.t.Object != "Base" then
            
                net.Start("HeistRegisterEntity")
                    net.WriteString(v.t.ObjectType)
                    net.WriteString(v.t.Base)
                    net.WriteString(v.t.PrintName)
                    net.WriteString(v.t.Category)
                    net.WriteString(v.t.Object)
                    net.WriteString(v.t.ClassName)
                net.Send(ply)

            end

        end

    end

end)