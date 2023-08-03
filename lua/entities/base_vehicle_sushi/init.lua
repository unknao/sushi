AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
include("damage.lua")
include("inputs.lua")
include("physics.lua")

function ENT:OnRemove()
	local timer_name = "sushi_base_ttl_"..self:EntIndex()
	if timer.Exists(timer_name) then timer.Remove(timer_name) end
end