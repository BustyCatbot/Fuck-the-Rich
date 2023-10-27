AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
 
ENT.PrintName		= "Spawner Base"
ENT.Category		= "Heist Spawner"
ENT.Spawnable		= true

ENT.Author			= "Catbot Studios"
ENT.Contact			= ""
ENT.Purpose			= ""
ENT.Instructions	= ""

ENT.Editable = true

ENT.ObjectType = "spawner"
ENT.Object = "Base"

function ENT:SetupDataTables()

	self:NetworkVar( "String",	0, "InstanceName",	{ KeyName = "instancename",	Edit = { type = "String",	order = 1 } } )
	self:NetworkVar( "Float",	0, "InstanceDelay",	{ KeyName = "instancedelay",	Edit = { type = "Float",	order = 1 } } )

end

if SERVER then
	
	function ENT:Initialize()

		self:SetNWString("HeistObjectName", HeistGetObject(self.ObjectType, self.Object)["name"])
		self:SetNWString("HeistObjectAction", HeistGetObject(self.ObjectType, self.Object)["action"])
	
		self:SetModel( HeistGetObject(self.ObjectType, self.Object)["model"] )
		self:PhysicsInit( SOLID_VPHYSICS )	  -- Make us work with physics,
		self:SetMoveType( MOVETYPE_VPHYSICS )   -- after all, gmod is a physics
		self:SetSolid( SOLID_VPHYSICS )		 -- Toolbox
	
		local phys = self:GetPhysicsObject()
		if (phys:IsValid()) then
			phys:Wake()
		end

		if self:GetNWString("HeistInstanceID") == "" then
			self:SetNWString("HeistInstanceID", math.random( 100000 ))
		end

		self:SetInstanceName(self:GetNWString("HeistObjectName").." "..self:GetNWString("HeistInstanceID"))
		self:SetInstanceDelay(0)

		if self.outputobjects == nil then
			self.outputobjects = {}
		end

	end
	
	function ENT:Use( activator, caller )

		for k,v in pairs(self.outputobjects) do

			local id = v

			for k,v in pairs(ents.FindByClass("heist_event_*")) do

				if v:GetNWString("HeistInstanceID") == id then

					v:EventInput()

				end

			end

		end

	end
	
	function ENT:Think()

		self:SetNWString("HeistInstanceName", self:GetInstanceName())
		self:SetNWString("HeistInstanceDelay", self:GetInstanceDelay())
		self:SetNWString("HeistOutputObjects", util.TableToJSON(self.outputobjects, false))

	end

else
	
	function ENT:Draw()

		self:DrawModel()

	end

end