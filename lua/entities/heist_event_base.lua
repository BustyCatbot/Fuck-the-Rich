AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
 
ENT.PrintName		= "Event Base"
ENT.Category		= "Heist Event"
ENT.Spawnable		= true

ENT.Author			= "Catbot Studios"
ENT.Contact			= ""
ENT.Purpose			= ""
ENT.Instructions	= ""

ENT.Editable = true

ENT.ObjectType = "event"
ENT.Object = "Base"

function ENT:SetupDataTables()

	self:NetworkVar( "String",	0, "InstanceName",	{ KeyName = "instancename",	Edit = { type = "String",	order = 1 } } )
	self:NetworkVar( "Float",	0, "InstanceDelay",	{ KeyName = "instancedelay",	Edit = { type = "Float",	order = 1 } } )

end

if SERVER then

	local outputs = {}
	
	function ENT:Initialize()

		self:SetNWString("HeistObjectName", HeistGetObject(self.ObjectType, self.Object)["name"])
		self:SetNWString("HeistObjectIcon", HeistGetObject(self.ObjectType, self.Object)["icon"])
		self:SetNWString("HeistObjectAction", HeistGetObject(self.ObjectType, self.Object)["action"])
		self:SetNWBool("HeistObjectInput", HeistGetObject(self.ObjectType, self.Object)["input"])
	
		self:SetModel( "models/hunter/blocks/cube025x025x025.mdl" )
		self:PhysicsInit( SOLID_VPHYSICS )	  -- Make us work with physics,
		self:SetMoveType( MOVETYPE_VPHYSICS )   -- after all, gmod is a physics
		self:SetSolid( SOLID_VPHYSICS )		 -- Toolbox
	
		self:PhysicsDestroy()
		self:SetCollisionGroup( COLLISION_GROUP_WORLD )

		if self:GetNWString("HeistInstanceID") == "" then
			self:SetNWString("HeistInstanceID", math.random( 100000 ))
		end

		self:SetInstanceName(self:GetNWString("HeistObjectName").." "..self:GetNWString("HeistInstanceID"))
		self:SetInstanceDelay(0)

		self:SetNWBool("Draw", true)
	
		if self.outputobjects == nil then
			self.outputobjects = {}
		end

		outputs = {
			["relay"] = function(entity)
	
				entity:EventInput()
	
			end,
			["enable"] = function(entity)
	
				entity:SetNWBool("HeistObjectEnabled", true)

			end,
			["disable"] = function(entity)
	
				entity:SetNWBool("HeistObjectEnabled", false)

			end,
			["activate"] = function(entity)
	
				entity:SetNWBool("HeistObjectActive", true)

			end,
			["deactivated"] = function(entity)
	
				entity:SetNWBool("HeistObjectActive", false)

			end,
			["remove"] = function(entity)

				if !GetConVar("sv_heist_editor"):GetBool() then
	
					entity:Remove()
	
				end
	
			end,
			["unlockdoor"] = function()
	
				for k,v in pairs(ents.FindInSphere( self:GetPos(), 64 )) do
	
					if v:GetClass() == "prop_door_rotating" then
	
						v:Fire( "unlock", nil, 0, nil, nil )
	
					end
	
				end
	
			end,
		}

	end

	function ENT:EventInput(activator)

		self:EventOutput()

	end

	function ENT:EventOutput(activator)

		timer.Simple(self:GetInstanceDelay(), function()

			if HeistGetObject(self.ObjectType, self.Object)["input"] then
		
				for k,v in pairs(self.outputobjects) do
	
					local id = v
	
					for k,v in pairs(ents.FindByClass("heist_*")) do
	
						if v:GetNWString("HeistInstanceID") == id then
	
							outputs[HeistGetObject(self.ObjectType, self.Object)["output"]](v)
							if GetConVar("sv_heist_editor"):GetBool() then
								self:EmitSound("buttons/blip1.wav", 75, 100, 1)
							end
	
						end
	
					end
	
				end
	
			else
	
				outputs[HeistGetObject(self.ObjectType, self.Object)["output"]]()
				if GetConVar("sv_heist_editor"):GetBool() then
					self:EmitSound("buttons/blip1.wav", 75, 100, 1)
				end
	
			end

		end)
		
	end
	
	function ENT:OnRemove()
		
		for k,v in pairs(ents.FindByClass("heist_*")) do
			if table.HasValue(v.outputobjects, self:GetNWString("HeistInstanceID")) then
				v["outputobjects"][table.KeyFromValue(v["outputobjects"], self:GetNWString("HeistInstanceID"))] = nil
			end
		end

	end
	
	function ENT:Use( activator, caller )

	end
	
	function ENT:Think()

		self:SetNWString("HeistInstanceName", self:GetInstanceName())
		self:SetNWString("HeistInstanceDelay", self:GetInstanceDelay())
		self:SetNWString("HeistOutputObjects", util.TableToJSON(self.outputobjects, false))

	end

else
	
	function ENT:Draw()

		self:DrawShadow(false)

		if self:GetNWBool("Draw") then

			local ply = LocalPlayer()

			if GetConVar("sv_heist_editor"):GetBool() then

				local pos = self:GetPos()
				local ang = ply:EyeAngles()
				ang:RotateAroundAxis(ang:Right(), 90)
				ang:RotateAroundAxis(ang:Up(), -90)

				cam.Start3D2D(pos, ang, 0.1)

					surface.SetMaterial(Material(self:GetNWString("HeistObjectIcon")))
					surface.SetDrawColor(255, 255, 255, 255)
					surface.DrawTexturedRect( -64, -64, 128, 128 )

				cam.End3D2D()

			end
		
		end

	end

end