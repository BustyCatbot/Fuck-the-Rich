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
            ["MedicBag"] = {
                name = "Medic Bag",
                model = "models/hunter/blocks/cube025x025x025.mdl",
                action = "Use",
                icon = "",
                stack = 1,
                dropsound = "",
            },
            ["ArmorBag"] = {
                name = "Armor Bag",
                model = "models/hunter/blocks/cube025x025x025.mdl",
                action = "Use",
                icon = "",
                stack = 1,
                dropsound = "",
            },
            ["AmmoBag"] = {
                name = "Ammo Bag",
                model = "models/hunter/blocks/cube025x025x025.mdl",
                action = "Use",
                icon = "",
                stack = 1,
                dropsound = "",
            },
            ["ThrowableBag"] = {
                name = "Throwable Bag",
                model = "models/hunter/blocks/cube025x025x025.mdl",
                action = "Use",
                icon = "",
                stack = 1,
                dropsound = "",
            },
        },
        enemies = {
            ["Base"] = {
                name = "",
            },
        },
        equipment = {
            ["Base"] = {
                name = "Equipment",
                category = "Base",
                model = "models/hunter/blocks/cube025x025x025.mdl",
                action = "Take",
                icon = "",
                requiredequipment = "",
                stack = 1,
                takesound = "",
                consumed = false,
            },
            ["Drill"] = {
                name = "Hand Drill",
                category = "Tool",
                model = "models/hunter/blocks/cube025x025x025.mdl",
                action = "Take",
                icon = "",
                requiredequipment = "",
                stack = 1,
                takesound = "",
                consumed = false,
            },
            ["Saw"] = {
                name = "Circular Saw",
                category = "Tool",
                model = "models/hunter/blocks/cube025x025x025.mdl",
                action = "Take",
                icon = "",
                requiredequipment = "",
                stack = 1,
                takesound = "",
                consumed = false,
            },
            ["Cutter"] = {
                name = "Blowtorch",
                category = "Tool",
                model = "models/hunter/blocks/cube025x025x025.mdl",
                action = "Take",
                icon = "",
                requiredequipment = "",
                stack = 1,
                takesound = "",
                consumed = false,
            },
            ["Device"] = {
                name = "Smartphone",
                category = "Tool",
                model = "models/hunter/blocks/cube025x025x025.mdl",
                action = "Take",
                icon = "",
                requiredequipment = "",
                stack = 1,
                takesound = "",
                consumed = false,
            },
            ["KeychainR"] = {
                name = "Red Keychain",
                category = "Security",
                model = "models/hunter/blocks/cube025x025x025.mdl",
                action = "Take",
                icon = "",
                requiredequipment = "",
                stack = 1,
                takesound = "",
                consumed = false,
            },
            ["KeychainG"] = {
                name = "Green Keychain",
                category = "Security",
                model = "models/hunter/blocks/cube025x025x025.mdl",
                action = "Take",
                icon = "",
                requiredequipment = "",
                stack = 1,
                takesound = "",
                consumed = false,
            },
            ["KeychainB"] = {
                name = "Blue Keychain",
                category = "Security",
                model = "models/hunter/blocks/cube025x025x025.mdl",
                action = "Take",
                icon = "",
                requiredequipment = "",
                stack = 1,
                takesound = "",
                consumed = false,
            },
            ["KeychainRG"] = {
                name = "Yellow Keychain",
                category = "Security",
                model = "models/hunter/blocks/cube025x025x025.mdl",
                action = "Take",
                icon = "",
                requiredequipment = "",
                stack = 1,
                takesound = "",
                consumed = false,
            },
            ["KeychainRB"] = {
                name = "Magenta Keychain",
                category = "Security",
                model = "models/hunter/blocks/cube025x025x025.mdl",
                action = "Take",
                icon = "",
                requiredequipment = "",
                stack = 1,
                takesound = "",
                consumed = false,
            },
            ["KeychainGB"] = {
                name = "Cyan Keychain",
                category = "Security",
                model = "models/hunter/blocks/cube025x025x025.mdl",
                action = "Take",
                icon = "",
                requiredequipment = "",
                stack = 1,
                takesound = "",
                consumed = false,
            },
            ["KeychainRGB"] = {
                name = "White Keychain",
                category = "Security",
                model = "models/hunter/blocks/cube025x025x025.mdl",
                action = "Take",
                icon = "",
                requiredequipment = "",
                stack = 1,
                takesound = "",
                consumed = false,
            },
            ["KeycardR"] = {
                name = "Red Keycard",
                category = "Security",
                model = "models/hunter/blocks/cube025x025x025.mdl",
                action = "Take",
                icon = "",
                requiredequipment = "",
                stack = 1,
                takesound = "",
                consumed = false,
            },
            ["KeycardG"] = {
                name = "Green Keycard",
                category = "Security",
                model = "models/hunter/blocks/cube025x025x025.mdl",
                action = "Take",
                icon = "",
                requiredequipment = "",
                stack = 1,
                takesound = "",
                consumed = false,
            },
            ["KeycardB"] = {
                name = "Blue Keycard",
                category = "Security",
                model = "models/hunter/blocks/cube025x025x025.mdl",
                action = "Take",
                icon = "",
                requiredequipment = "",
                stack = 1,
                takesound = "",
                consumed = false,
            },
            ["KeycardRG"] = {
                name = "Yellow Keycard",
                category = "Security",
                model = "models/hunter/blocks/cube025x025x025.mdl",
                action = "Take",
                icon = "",
                requiredequipment = "",
                stack = 1,
                takesound = "",
                consumed = false,
            },
            ["KeycardRB"] = {
                name = "Magenta Keycard",
                category = "Security",
                model = "models/hunter/blocks/cube025x025x025.mdl",
                action = "Take",
                icon = "",
                requiredequipment = "",
                stack = 1,
                takesound = "",
                consumed = false,
            },
            ["KeycardGB"] = {
                name = "Cyan Keycard",
                category = "Security",
                model = "models/hunter/blocks/cube025x025x025.mdl",
                action = "Take",
                icon = "",
                requiredequipment = "",
                stack = 1,
                takesound = "",
                consumed = false,
            },
            ["KeycardRGB"] = {
                name = "White Keycard",
                category = "Security",
                model = "models/hunter/blocks/cube025x025x025.mdl",
                action = "Take",
                icon = "",
                requiredequipment = "",
                stack = 1,
                takesound = "",
                consumed = false,
            },
            ["FingerprintR"] = {
                name = "Red Fingerprint",
                category = "Security",
                model = "models/hunter/blocks/cube025x025x025.mdl",
                action = "Take",
                icon = "",
                requiredequipment = "",
                stack = 1,
                takesound = "",
                consumed = false,
            },
            ["FingerprintG"] = {
                name = "Green Fingerprint",
                category = "Security",
                model = "models/hunter/blocks/cube025x025x025.mdl",
                action = "Take",
                icon = "",
                requiredequipment = "",
                stack = 1,
                takesound = "",
                consumed = false,
            },
            ["FingerprintB"] = {
                name = "Blue Fingerprint",
                category = "Security",
                model = "models/hunter/blocks/cube025x025x025.mdl",
                action = "Take",
                icon = "",
                requiredequipment = "",
                stack = 1,
                takesound = "",
                consumed = false,
            },
            ["FingerprintRG"] = {
                name = "Yellow Fingerprint",
                category = "Security",
                model = "models/hunter/blocks/cube025x025x025.mdl",
                action = "Take",
                icon = "",
                requiredequipment = "",
                stack = 1,
                takesound = "",
                consumed = false,
            },
            ["FingerprintRB"] = {
                name = "Magenta Fingerprint",
                category = "Security",
                model = "models/hunter/blocks/cube025x025x025.mdl",
                action = "Take",
                icon = "",
                requiredequipment = "",
                stack = 1,
                takesound = "",
                consumed = false,
            },
            ["FingerprintGB"] = {
                name = "Cyan Fingerprint",
                category = "Security",
                model = "models/hunter/blocks/cube025x025x025.mdl",
                action = "Take",
                icon = "",
                requiredequipment = "",
                stack = 1,
                takesound = "",
                consumed = false,
            },
            ["FingerprintRGB"] = {
                name = "White Fingerprint",
                category = "Security",
                model = "models/hunter/blocks/cube025x025x025.mdl",
                action = "Take",
                icon = "",
                requiredequipment = "",
                stack = 1,
                takesound = "",
                consumed = false,
            },
            ["DriveR"] = {
                name = "Red Drive",
                category = "Security",
                model = "models/hunter/blocks/cube025x025x025.mdl",
                action = "Take",
                icon = "",
                requiredequipment = "",
                stack = 1,
                takesound = "",
                consumed = false,
            },
            ["DriveG"] = {
                name = "Green Drive",
                category = "Security",
                model = "models/hunter/blocks/cube025x025x025.mdl",
                action = "Take",
                icon = "",
                requiredequipment = "",
                stack = 1,
                takesound = "",
                consumed = false,
            },
            ["DriveB"] = {
                name = "Blue Drive",
                category = "Security",
                model = "models/hunter/blocks/cube025x025x025.mdl",
                action = "Take",
                icon = "",
                requiredequipment = "",
                stack = 1,
                takesound = "",
                consumed = false,
            },
            ["DriveRG"] = {
                name = "Yellow Drive",
                category = "Security",
                model = "models/hunter/blocks/cube025x025x025.mdl",
                action = "Take",
                icon = "",
                requiredequipment = "",
                stack = 1,
                takesound = "",
                consumed = false,
            },
            ["DriveRB"] = {
                name = "Magenta Drive",
                category = "Security",
                model = "models/hunter/blocks/cube025x025x025.mdl",
                action = "Take",
                icon = "",
                requiredequipment = "",
                stack = 1,
                takesound = "",
                consumed = false,
            },
            ["DriveGB"] = {
                name = "Cyan Drive",
                category = "Security",
                model = "models/hunter/blocks/cube025x025x025.mdl",
                action = "Take",
                icon = "",
                requiredequipment = "",
                stack = 1,
                takesound = "",
                consumed = false,
            },
            ["DriveRGB"] = {
                name = "White Drive",
                category = "Security",
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
                weight = 0,
                requiredequipment = "",
                usetime = 1,
                usetext = "Bag the Loot",
                startsound = "",
                usingsound = "",
                canceledsound = "",
                usedsound = "",
                loose = false,
                resultloot = "Base",
            },
            ["MoneyLoose"] = {
                name = "Money Bundle",
                model = "models/hunter/blocks/cube025x025x025.mdl",
                icon = "",
                action = "Take",
                weight = 0,
                requiredequipment = "",
                usetime = 1,
                usetext = "Grab the Money",
                startsound = "",
                usingsound = "",
                canceledsound = "",
                usedsound = "",
                loose = true,
            },
            ["MoneyPile"] = {
                name = "Money",
                model = "models/hunter/blocks/cube025x025x025.mdl",
                icon = "",
                action = "Take",
                weight = 0,
                requiredequipment = "",
                usetime = 1,
                usetext = "Bag the Money",
                startsound = "",
                usingsound = "",
                canceledsound = "",
                usedsound = "",
                resultloot = "MoneyBag",
            },
            ["MoneyBag"] = {
                name = "Bagged Money",
                model = "models/hunter/blocks/cube025x025x025.mdl",
                icon = "",
                action = "Take",
                weight = 0,
                requiredequipment = "",
                usetime = 1,
                usetext = "Take the Money Bag",
                startsound = "",
                usingsound = "",
                canceledsound = "",
                usedsound = "",
                resultloot = "",
            },
            ["GoldLoose"] = {
                name = "Gold Bar",
                model = "models/hunter/blocks/cube025x025x025.mdl",
                icon = "",
                action = "Take",
                weight = 0,
                requiredequipment = "",
                usetime = 1,
                usetext = "Grab the Gold Bar",
                startsound = "",
                usingsound = "",
                canceledsound = "",
                usedsound = "",
                loose = true,
            },
            ["GoldPile"] = {
                name = "Gold",
                model = "models/hunter/blocks/cube025x025x025.mdl",
                icon = "",
                action = "Take",
                weight = 0,
                requiredequipment = "",
                usetime = 1,
                usetext = "Bag the Gold",
                startsound = "",
                usingsound = "",
                canceledsound = "",
                usedsound = "",
                resultloot = "GoldBag",
            },
            ["GoldBag"] = {
                name = "Bagged Gold",
                model = "models/hunter/blocks/cube025x025x025.mdl",
                icon = "",
                action = "Take",
                weight = 0,
                requiredequipment = "",
                usetime = 1,
                usetext = "Take the Gold Bag",
                startsound = "",
                usingsound = "",
                canceledsound = "",
                usedsound = "",
                resultloot = "",
            },
            ["JewelryLoose"] = {
                name = "Jewelry Piece",
                model = "models/hunter/blocks/cube025x025x025.mdl",
                icon = "",
                action = "Take",
                weight = 0,
                requiredequipment = "",
                usetime = 1,
                usetext = "Grab the Jewelry",
                startsound = "",
                usingsound = "",
                canceledsound = "",
                usedsound = "",
                loose = true,
            },
            ["JewelryPile"] = {
                name = "Jewelry",
                model = "models/hunter/blocks/cube025x025x025.mdl",
                icon = "",
                action = "Take",
                weight = 0,
                requiredequipment = "",
                usetime = 1,
                usetext = "Bag the Jewelry",
                startsound = "",
                usingsound = "",
                canceledsound = "",
                usedsound = "",
                resultloot = "JewelryBag",
            },
            ["JewelryBag"] = {
                name = "Bagged Jewelry",
                model = "models/hunter/blocks/cube025x025x025.mdl",
                icon = "",
                action = "Take",
                weight = 0,
                requiredequipment = "",
                usetime = 1,
                usetext = "Take the Jewelry Bag",
                startsound = "",
                usingsound = "",
                canceledsound = "",
                usedsound = "",
                resultloot = "",
            },
            ["CokeLoose"] = {
                name = "Coke Pouch",
                model = "models/hunter/blocks/cube025x025x025.mdl",
                icon = "",
                action = "Take",
                weight = 0,
                requiredequipment = "",
                usetime = 1,
                usetext = "Grab the Coke",
                startsound = "",
                usingsound = "",
                canceledsound = "",
                usedsound = "",
                loose = true,
            },
            ["CokePile"] = {
                name = "Coke",
                model = "models/hunter/blocks/cube025x025x025.mdl",
                icon = "",
                action = "Take",
                weight = 0,
                requiredequipment = "",
                usetime = 1,
                usetext = "Bag the Coke",
                startsound = "",
                usingsound = "",
                canceledsound = "",
                usedsound = "",
                resultloot = "CokeBag",
            },
            ["CokeBag"] = {
                name = "Bagged Coke",
                model = "models/hunter/blocks/cube025x025x025.mdl",
                icon = "",
                action = "Take",
                weight = 0,
                requiredequipment = "",
                usetime = 1,
                usetext = "Take the Coke Bag",
                startsound = "",
                usingsound = "",
                canceledsound = "",
                usedsound = "",
                resultloot = "",
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
            ["Drill2"] = {
                name = "Thermal Drill",
                model = "models/hunter/blocks/cube025x025x025.mdl",
                icon = "",
                action = "Place",
                requiredequipment = "",
                placetime = 1,
                placetext = "Place the Drill",
                startplacesound = "",
                placingsound = "",
                canceledplacesound = "",
                placedsound = "",
                fixtime = 1,
                fixtext = "Fix the Drill",
                startfixsound = "",
                fixingsound = "",
                canceledfixsound = "",
                fixedsound = "",
            },
            ["Drill3"] = {
                name = "Beast Drill",
                model = "models/hunter/blocks/cube025x025x025.mdl",
                icon = "",
                action = "Place",
                requiredequipment = "",
                placetime = 1,
                placetext = "Place the Drill",
                startplacesound = "",
                placingsound = "",
                canceledplacesound = "",
                placedsound = "",
                fixtime = 1,
                fixtext = "Fix the Drill",
                startfixsound = "",
                fixingsound = "",
                canceledfixsound = "",
                fixedsound = "",
            },
            ["Saw2"] = {
                name = "Buzz Saw",
                model = "models/hunter/blocks/cube025x025x025.mdl",
                icon = "",
                action = "Place",
                requiredequipment = "",
                placetime = 1,
                placetext = "Place the Saw",
                startplacesound = "",
                placingsound = "",
                canceledplacesound = "",
                placedsound = "",
                fixtime = 1,
                fixtext = "Fix the Saw",
                startfixsound = "",
                fixingsound = "",
                canceledfixsound = "",
                fixedsound = "",
            },
            ["Saw3"] = {
                name = "Industrial Saw",
                model = "models/hunter/blocks/cube025x025x025.mdl",
                icon = "",
                action = "Place",
                requiredequipment = "",
                placetime = 1,
                placetext = "Place the Saw",
                startplacesound = "",
                placingsound = "",
                canceledplacesound = "",
                placedsound = "",
                fixtime = 1,
                fixtext = "Fix the Saw",
                startfixsound = "",
                fixingsound = "",
                canceledfixsound = "",
                fixedsound = "",
            },
            ["Cutter2"] = {
                name = "Laser Cutter",
                model = "models/hunter/blocks/cube025x025x025.mdl",
                icon = "",
                action = "Place",
                requiredequipment = "",
                placetime = 1,
                placetext = "Place the Cutter",
                startplacesound = "",
                placingsound = "",
                canceledplacesound = "",
                placedsound = "",
                fixtime = 1,
                fixtext = "Fix the Cutter",
                startfixsound = "",
                fixingsound = "",
                canceledfixsound = "",
                fixedsound = "",
            },
            ["Cutter3"] = {
                name = "Industrial Cutter",
                model = "models/hunter/blocks/cube025x025x025.mdl",
                icon = "",
                action = "Place",
                requiredequipment = "",
                placetime = 1,
                placetext = "Place the Cutter",
                startplacesound = "",
                placingsound = "",
                canceledplacesound = "",
                placedsound = "",
                fixtime = 1,
                fixtext = "Fix the Cutter",
                startfixsound = "",
                fixingsound = "",
                canceledfixsound = "",
                fixedsound = "",
            },
            ["Device2"] = {
                name = "Laptop",
                model = "models/hunter/blocks/cube025x025x025.mdl",
                icon = "",
                action = "Place",
                requiredequipment = "",
                placetime = 1,
                placetext = "Place the Device",
                startplacesound = "",
                placingsound = "",
                canceledplacesound = "",
                placedsound = "",
                fixtime = 1,
                fixtext = "Fix the Device",
                startfixsound = "",
                fixingsound = "",
                canceledfixsound = "",
                fixedsound = "",
            },
            ["Device3"] = {
                name = "Tower Computer",
                model = "models/hunter/blocks/cube025x025x025.mdl",
                icon = "",
                action = "Place",
                requiredequipment = "",
                placetime = 1,
                placetext = "Place the Device",
                startplacesound = "",
                placingsound = "",
                canceledplacesound = "",
                placedsound = "",
                fixtime = 1,
                fixtext = "Fix the Device",
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
        throwable = {
            ["Base"] = {
                name = "",
                icon = "",
                model = "",
            },
        },
        weapon = {
            ["Base"] = {
                name = "",
                icon = "",
                model = "",
                entity = "none",
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