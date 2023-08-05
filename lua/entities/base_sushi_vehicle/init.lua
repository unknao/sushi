AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
include("damage.lua")
include("inputs.lua")
include("physics.lua")

ENT.Sounds = {
	Enable = {},
	Disable = {},
	OnLoop = {},
	TakeDamage = {}, --Pick randomly
	Destroyed = {},
}

function ENT:Initialize()
	self:SetupInputs()
	
	if WireLib then
		self.Inputs = WireLib.CreateInputs(self, {
			"Active",
			"Lights",
		})	
		
		self.Outputs = WireLib.CreateOutputs(self, {
			"Active",
			"Lights",
			"WS (Forwards & Backwards composite ranging from -1 to 1.)",
			"AD (Left & Right composite ranging from -1 to 1.)"
		})
	end
end

function ENT:OnRemove()
	local timer_name = "sushi_base_ttl_"..self:EntIndex()
	if timer.Exists(timer_name) then timer.Remove(timer_name) end
end