ENT.CanOnlyBeDamagedByExplosions = false
ENT.Unbreakable = false
ENT.MaxHealth = 1000

local corpse_ttl = CreateConVar("sushi_base_destroyed_ttl", 30, {FCVAR_ARCHIVE}, "Sets the sushi base vehicle corpse lifetime before it's removed (setting this to 0 disables corpse removal).", 0, math.huge)

function ENT:Health()
	return self:GetHealth()
end

function ENT:GetMaxHealth()
	return self.MaxHealth
end

function ENT:OnTakeDamage(dmginfo)
	if not self.Initialized then return end
	if self:GetDestroyed() then return end
	if not IsValid(dmginfo) then return end
	if self.CanOnlyBeDamagedByExplosions and not dmginfo:IsExplosionDamage() then return end
	
	local change_health = math.max(self:GetHealth() - dmginfo:GetDamage(), 0)
	self:SetHealth(change_health)
	if change_health ~= 0 then return end
	
	self:SetDestroyed(true)
end

function ENT:OnDestroyed()
	print("oh no, im dead!")
	ENT:DoDestructionEffect()
	if corpse_ttl:GetInt() == 0 then return end
	
	timer.Create("sushi_base_ttl_"..self:EntIndex(), corpse_ttl:GetInt(), 1, function()
		SafeRemoveEntity(self)
	end)
end

function ENT:DoDestructionEffect()
	local Effect = EffectData()
	Effect:SetOrigin(self:GetPos())
	Effect:SetMagnitude(100)
	Effect:SetScale(100)
	util.Effect("Explosion", Effect, true, true)
end



