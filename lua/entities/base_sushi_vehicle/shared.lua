ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName = "Hovercraft"
ENT.Author = "unknao"

ENT.Information = ""
ENT.Spawnable = false
ENT.RenderGroup = RENDERGROUP_BOTH 
ENT.WarmupTime = 2
ENT.IsSushiBase = true

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "WS")
	self:NetworkVar("Int", 1, "AD")
	self:NetworkVar("Int", 2, "SprintWalk")
	
	self:NetworkVar("Float", 0, "Health")
	
	self:NetworkVar("Entity", 0, "Driver")
	
	self:NetworkVar("Bool", 0, "On")
	self:NetworkVar("Bool", 1, "LightsOn")
	self:NetworkVar("Bool", 2, "Destroyed")
	self:NetworkVar("Bool", 3, "Jump")
	self:NetworkVar("Bool", 4, "Attack")
	self:NetworkVar("Bool", 5, "Attack2")
	
	if SERVER then
		self:NetworkVarNotify("Destroyed", function(_, old, new)
			if old == new then return end
			if new == false then return end
			
			self:OnDestroyed()
		end)
		
		self:NetworkVarNotify("On", function(_, old, new)
			if old == new then return end
			
			self:ChangeActiveState(new)
		end)		
		
		self:NetworkVarNotify("LightsOn", function(_, old, new)
			if old == new then return end
			
			self:ChangeLightState(new)
		end)
	end
end





	
