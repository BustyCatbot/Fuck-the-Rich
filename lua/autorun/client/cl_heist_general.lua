AddCSLuaFile()

function DrawRingSegment(x, y, radius, thickness, progress, color)
    local segments = 40 -- Number of segments for smoothness
    local startAng = 0
    local endAng = 360 * progress
    
    surface.SetDrawColor(color.r, color.g, color.b, color.a) -- Set color to white (RGBA)

    for i = 0, segments - 1 do
        local fraction = i / segments
        local angle = startAng + (endAng - startAng) * fraction
        local nx1, ny1 = x + math.cos(math.rad(angle)) * (radius - thickness), y + math.sin(math.rad(angle)) * (radius - thickness)
        local nx2, ny2 = x + math.cos(math.rad(angle)) * radius, y + math.sin(math.rad(angle)) * radius

        local nextFraction = (i + 1) / segments
        local nextAngle = startAng + (endAng - startAng) * nextFraction
        local nx1n, ny1n = x + math.cos(math.rad(nextAngle)) * (radius - thickness), y + math.sin(math.rad(nextAngle)) * (radius - thickness)
        local nx2n, ny2n = x + math.cos(math.rad(nextAngle)) * radius, y + math.sin(math.rad(nextAngle)) * radius

        surface.DrawPoly({
            { x = nx2, y = ny2 },
            { x = nx2n, y = ny2n },
            { x = nx1n, y = ny1n },
            { x = nx1, y = ny1 },
        })
    end
end

hook.Add( "PreDrawEffects", "HeistEffects", function()

    local ply = LocalPlayer()

    if GetConVar("sv_heist_editor"):GetBool() then

        if ply:GetNWEntity("HeistInputEvent", nil) != ply then

            if IsValid(ply:GetNWEntity("HeistInputEvent", nil)) then

                render.SetMaterial(Material("vgui/gradient_down"))
                render.DrawBeam( ply:GetNWEntity("HeistInputEvent"):GetPos(), ply:GetEyeTrace().HitPos, 1, 0, 1, Color( 128, 255, 128 ), false )
                render.DrawBeam( ply:GetEyeTrace().HitPos, ply:GetNWEntity("HeistInputEvent"):GetPos(), 1, 0, 1, Color( 255, 255, 255 ), false )

            end

        end

        for k,v in pairs(ents.FindByClass("heist_*")) do

            local ent = v

            local pos = ent:GetPos()
            local ang = ply:EyeAngles()
            ang:RotateAroundAxis(ang:Right(), 90)
            ang:RotateAroundAxis(ang:Up(), -90)

            if ply:GetEyeTrace().Entity == ent then
                cam.IgnoreZ(true)
            end

            cam.Start3D2D(pos, ang, 0.1)

                draw.SimpleTextOutlined( ent:GetNWString("HeistObjectName"), "CloseCaption_Bold", 0, -64, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 1, Color( 16, 16, 16 ) )
                draw.SimpleTextOutlined( ent:GetNWString("HeistInstanceName"), "CloseCaption_Normal", 0, 64, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Color( 16, 16, 16 ) )
                draw.SimpleTextOutlined( ent:GetNWString("HeistInstanceID"), "ChatFont", 0, 88, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Color( 16, 16, 16 ) )

            cam.End3D2D()

            cam.IgnoreZ(false)

            if util.JSONToTable(ent:GetNWString("HeistOutputObjects")) != nil and GetConVar("sv_heist_editor"):GetBool() then

                for k,v in pairs(util.JSONToTable(ent:GetNWString("HeistOutputObjects"))) do

                    local target = nil
                    local targetref = v

                    for k,v in pairs(ents.FindByClass("heist_*")) do

                        if v:GetNWString("HeistInstanceID") == targetref then

                            target = v

                        end

                    end
                    
                    if target != nil then

                        if ply:GetEyeTrace().Entity == ent or ply:GetEyeTrace().HitEntity == target then
                            cam.IgnoreZ(true)
                        end

                        render.SetMaterial(Material("vgui/gradient_down"))
                        render.DrawBeam( ent:GetPos(), target:GetPos(), 1, 0, 1, Color( 128, 255, 128 ), false )
                        render.DrawBeam( target:GetPos(), ent:GetPos(), 1, 0, 1, Color( 255, 255, 255 ), false )

                        local pos = ent:GetPos() - (ent:GetPos() - target:GetPos()) * 0.5
                        local ang = ply:EyeAngles()
                        ang:RotateAroundAxis(ang:Right(), 90)
                        ang:RotateAroundAxis(ang:Up(), -90)

                        cam.Start3D2D(pos, ang, 0.1)

                            draw.SimpleTextOutlined( ent:GetNWString("HeistObjectName"), "CloseCaption_Bold", 0, -16, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 16, 16, 16 ) )
                            draw.SimpleTextOutlined( ent:GetNWString("HeistObjectAction"), "CloseCaption_Italic", 0, 16, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 16, 16, 16 ) )

                        cam.End3D2D()

                        cam.IgnoreZ(false)

                    end

                end

            end

        end

    end

    for k,v in pairs(ents.FindByClass("heist_activator_*")) do

        if v:GetNWBool("HeistObjectEnabled") then

            local pos = v:GetPos() - (v:GetPos() - ply:EyePos() - ply:EyeAngles():Forward() * 100) * 0.5
            local ang = ply:EyeAngles()
            ang:RotateAroundAxis(ang:Right(), 90)
            ang:RotateAroundAxis(ang:Up(), -90)

            if v:GetPos():Distance(ply:EyePos()) < 64 then

                if ply == v:GetNWEntity("HeistObjectUsePlayer") and v:GetNWEntity("HeistObjectUsing") then

                    render.SetMaterial(Material("vgui/gradient_down"))
                    render.DrawBeam( v:GetPos(), pos, 1, 0, 1, Color( 128, 255, 192 ), false )

                    surface.SetFont("CloseCaption_Normal")
                    local width, height = surface.GetTextSize( v:GetNWString("HeistObjectUsingText") )

                    cam.Start3D2D(pos, ang, 0.075)

                        cam.IgnoreZ(true)

                        DrawRingSegment(0, 0, width * 0.7, 16, math.Clamp((CurTime() - v:GetNWFloat("HeistObjectUseTarget") + v:GetNWFloat("HeistObjectUseTime")) / v:GetNWFloat("HeistObjectUseTime"), 0, 1), Color(128,255,192,255))

                        draw.SimpleTextOutlined( v:GetNWString("HeistObjectUsingText"), "CloseCaption_Normal", 0, 0, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 16, 16, 16 ) )
                        
                        cam.IgnoreZ(false)

                    cam.End3D2D()

                elseif v == ply:GetUseEntity() and !ply:GetNWBool("HeistObjectPlayerUsing") then

                    render.SetMaterial(Material("vgui/gradient_down"))
                    render.DrawBeam( v:GetPos(), pos, 1, 0, 1, Color( 255, 255, 255 ), false )

                    cam.Start3D2D(pos, ang, 0.075)

                        cam.IgnoreZ(true)

                        draw.SimpleTextOutlined( v:GetNWString("HeistObjectUseText"), "CloseCaption_Normal", 0, 0, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 16, 16, 16 ) )
                        
                        cam.IgnoreZ(false)

                    cam.End3D2D()

                end

            end

        end

    end

end)

net.Receive("HeistRegisterEntity", function()

        local ent = {}

        ent.ObjectType = net.ReadString()

        ent.Type = "anim"
        ent.Base = net.ReadString()

        ent.PrintName = net.ReadString()
        ent.Category = net.ReadString()
        ent.Author = "Catbot Studios"

        ent.Spawnable = true
        ent.Object = net.ReadString()

        local classname = net.ReadString()

        scripted_ents.Register( ent, classname )

        print("[FtR]    "..scripted_ents.GetMember( classname, "PrintName" ).." Initialized on Client")

end)

hook.Add("CalcViewModelView", "HeistViewModelCam", function( wep, vm, oldPos, oldAng, pos, ang )

end)