AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
 
ENT.PrintName		= "Activator Base"
ENT.Category		= "Heist Activator"
ENT.Spawnable		= true

ENT.Author			= "Catbot Studios"
ENT.Contact			= ""
ENT.Purpose			= ""
ENT.Instructions	= ""

ENT.Editable = true

ENT.ObjectType = "activator"
ENT.Object = "Base"

function ENT:SetupDataTables()

	self:NetworkVar( "String",	0, "InstanceName",	{ KeyName = "instancename",	Edit = { type = "String",	order = 1 } } )
	self:NetworkVar( "Float",	0, "InstanceDelay",	{ KeyName = "instancedelay",	Edit = { type = "Float",	order = 1 } } )

end

if SERVER then
	
	function ENT:Initialize()

		self:SetNWString("HeistObjectName", HeistGetObject(self.ObjectType, self.Object)["name"])
		self:SetNWString("HeistObjectAction", HeistGetObject(self.ObjectType, self.Object)["action"])
		self:SetNWString("HeistObjectIcon", HeistGetObject(self.ObjectType, self.Object)["icon"])
		self:SetNWString("HeistObjectUseText", HeistGetObject(self.ObjectType, self.Object)["usetext"])
		self:SetNWString("HeistObjectUsingText", HeistGetObject(self.ObjectType, self.Object)["usingtext"])
		self:SetNWString("HeistObjectType", HeistGetObject(self.ObjectType, self.Object)["type"])

		self:SetNWBool("HeistObjectEnabled", HeistGetObject(self.ObjectType, self.Object)["enabled"])
		
		self:SetNWBool("HeistObjectUsing", false)
		self:SetNWFloat("HeistObjectUseTime", HeistGetObject(self.ObjectType, self.Object)["usetime"])
		self:SetNWFloat("HeistObjectUseTarget", 0)
		self:SetNWEntity("HeistObjectUsePlayer", nil)
	
		if HeistGetObject(self.ObjectType, self.Object)["type"] == "interaction" then

			self:SetModel( "models/hunter/plates/plate025x025.mdl" )
			
		else

			self:SetModel( HeistGetObject(self.ObjectType, self.Object)["model"] )

		end

		self:PhysicsInit( SOLID_VPHYSICS )	  -- Make us work with physics,
		self:SetMoveType( MOVETYPE_VPHYSICS )   -- after all, gmod is a physics
		self:SetSolid( SOLID_VPHYSICS )		 -- Toolbox
	
		local phys = self:GetPhysicsObject()
		if (phys:IsValid()) then
			phys:Wake()
		end

		if HeistGetObject(self.ObjectType, self.Object)["type"] == "interaction" then

			self:PhysicsDestroy()
			self:SetCollisionGroup( COLLISION_GROUP_WORLD )

		end

		if self:GetNWString("HeistInstanceID") == "" then
			self:SetNWString("HeistInstanceID", math.random( 100000 ))
		end

		self:SetInstanceName(self:GetNWString("HeistObjectName").." "..self:GetNWString("HeistInstanceID"))
		self:SetInstanceDelay(0)

		if self.outputobjects == nil then
			self.outputobjects = {}
		end

		self:SetUseType(SIMPLE_USE)

	end

	function ENT:EventOutput(activator)
	end
	
	function ENT:Use( activator, caller )

		if self:GetNWBool("HeistObjectEnabled") then

			if self:GetPos():Distance(activator:EyePos()) < 64 and !activator:GetNWBool("HeistObjectPlayerUsing") then

				if self:GetNWBool("HeistObjectUsing") then

				else

					self:EmitSound(HeistGetObject(self.ObjectType, self.Object)["startsound"], 75, 100, 1)
					self:EmitSound(HeistGetObject(self.ObjectType, self.Object)["usingsound"], 75, 100, 1)
					self:SetNWBool("HeistObjectUsing", true)
					activator:SetNWBool("HeistObjectPlayerUsing", true)
					self:SetNWFloat("HeistObjectUseTarget", CurTime() + self:GetNWFloat("HeistObjectUseTime"))
					self:SetNWEntity("HeistObjectUsePlayer", activator)

				end

			end

		end

	end

	function ENT:OnRemove()
		
		for k,v in pairs(ents.FindByClass("heist_*")) do
			if table.HasValue(v.outputobjects, self:GetNWString("HeistInstanceID")) then
				v["outputobjects"][table.KeyFromValue(v["outputobjects"], self:GetNWString("HeistInstanceID"))] = nil
			end
		end

	end
	
	function ENT:Think()

		self:SetNWString("HeistInstanceName", self:GetInstanceName())
		self:SetNWString("HeistInstanceDelay", self:GetInstanceDelay())
		self:SetNWString("HeistOutputObjects", util.TableToJSON(self.outputobjects, false))

		if self:GetNWBool("HeistObjectEnabled") then

			if self:GetNWString("HeistObjectType") != "interaction" then

				self:SetCollisionGroup( COLLISION_GROUP_NONE )

			end

			if self:GetNWBool("HeistObjectUsing") then

				if self:GetNWEntity("HeistObjectUsePlayer"):KeyDown(IN_USE) and self:GetPos():Distance(self:GetNWEntity("HeistObjectUsePlayer"):EyePos()) < 64 then
					if CurTime() > self:GetNWFloat("HeistObjectUseTarget") then

						self:EmitSound(HeistGetObject(self.ObjectType, self.Object)["usedsound"], 75, 100, 1)
						self:StopSound(HeistGetObject(self.ObjectType, self.Object)["usingsound"])
						self:SetNWFloat("HeistObjectUseTarget", 0)
						self:GetNWEntity("HeistObjectUsePlayer"):SetNWBool("HeistObjectPlayerUsing", false)
						self:SetNWBool("HeistObjectUsing", false)
						if HeistGetObject(self.ObjectType, self.Object)["consume"] and !GetConVar("sv_heist_editor"):GetBool() then

							self:Remove()

						end

						for k,v in pairs(self.outputobjects) do

							local id = v
			
							for k,v in pairs(ents.FindByClass("heist_event_*")) do
			
								if v:GetNWString("HeistInstanceID") == id then
			
									v:EventInput()
			
								end
			
							end
			
						end

					end
					
				else

					self:EmitSound(HeistGetObject(self.ObjectType, self.Object)["canceledsound"], 75, 100, 1)
					self:StopSound(HeistGetObject(self.ObjectType, self.Object)["usingsound"])
					self:SetNWFloat("HeistObjectUseTarget", 0)
					self:GetNWEntity("HeistObjectUsePlayer"):SetNWBool("HeistObjectPlayerUsing", false)
					self:SetNWBool("HeistObjectUsing", false)

				end

			end

		else

			if self:GetNWString("HeistObjectType") != "interactable" then

				self:SetCollisionGroup( COLLISION_GROUP_WORLD )

			end

		end

	end

else

	function ENT:Initialize()

		self:SetNWFloat("HeistObjectAlpha", 0)

	end
	
	function ENT:Draw()

		local ply = LocalPlayer()

		if self:GetNWString("HeistObjectType") == "interaction" then

			local pos = self:GetPos()
			local ang = self:GetAngles()
			ang:RotateAroundAxis(ang:Up(), 90)

			local alpha = 0

			if self:GetPos():Distance(ply:EyePos()) < 64 then

				alpha = 255

			elseif self:GetPos():Distance(ply:EyePos()) < 256 then

				alpha = 128

			else

				alpha = 0

			end

			self:SetNWFloat("HeistObjectAlpha", Lerp(0.1, self:GetNWFloat("HeistObjectAlpha"), alpha))

			local color = Color(255,255,255,self:GetNWFloat("HeistObjectAlpha"))

			if self:GetNWBool("HeistObjectUsing") then

				color = Color(128,255,192,self:GetNWFloat("HeistObjectAlpha"))

			else

				color = Color(255,255,255,self:GetNWFloat("HeistObjectAlpha"))

			end

			if self:GetNWBool("HeistObjectEnabled") then

			cam.Start3D2D(pos, ang, 0.1)

				surface.SetDrawColor( color )
				surface.DrawPoly( {
					{x = -60, y = -60},
					{x = -20, y = -60},
					{x = -20, y = -50},
					{x = -50, y = -50},
					{x = -50, y = -20},
					{x = -60, y = -20},
				} )

				surface.SetDrawColor( color )
				surface.DrawPoly( {
					{x = -60, y = 60},
					{x = -60, y = 20},
					{x = -50, y = 20},
					{x = -50, y = 50},
					{x = -20, y = 50},
					{x = -20, y = 60},
				} )

				surface.SetDrawColor( color )
				surface.DrawPoly( {
					{x = 60, y = 60},
					{x = 20, y = 60},
					{x = 20, y = 50},
					{x = 50, y = 50},
					{x = 50, y = 20},
					{x = 60, y = 20},
				} )

				surface.SetDrawColor( color )
				surface.DrawPoly( {
					{x = 60, y = -60},
					{x = 60, y = -20},
					{x = 50, y = -20},
					{x = 50, y = -50},
					{x = 20, y = -50},
					{x = 20, y = -60},
				} )

				if self:GetNWBool("HeistObjectUsing") then

					DrawRingSegment(0, 0, 50, 10, math.Clamp((CurTime() - self:GetNWFloat("HeistObjectUseTarget") + self:GetNWFloat("HeistObjectUseTime")) / self:GetNWFloat("HeistObjectUseTime"), 0, 1), Color(128,255,192,255))

				end

				surface.SetMaterial(Material(self:GetNWString("HeistObjectIcon")))
				surface.SetDrawColor(255, 255, 255, self:GetNWFloat("HeistObjectAlpha"))
				surface.DrawTexturedRect( -32, -32, 64, 64 )

			cam.End3D2D()

			end

		else

			if self:GetNWBool("HeistObjectEnabled") then

				self:SetMaterial("")
				self:DrawModel()

			else

				if GetConVar("sv_heist_editor"):GetBool() then

					self:SetMaterial("models/wireframe")
					self:DrawModel()

				else

				end

			end

		end
		
	end

end