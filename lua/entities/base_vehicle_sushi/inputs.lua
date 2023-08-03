local tag = "sushi_base_inputs"

ENT.Boost_Multiplier = 1

local function handle_inputs(veh, key, binding, is_pressed)
	--If keys are numbers, attempt to change seats.
	if key <= 10 then sushi.MusicalChairs(veh, key) return end
	
	--Convert to numerals for easier use with logic
	local bool_to_num = is_pressed and 1 or 0
	if binding == "forward" then self.Fwd = bool_to_num end
	elseif binding == "back" then self.Bck = bool_to_num end
	elseif binding == "left" then self.Left = bool_to_num end
	elseif binding == "right" then self.Right = bool_to_num end
	elseif binding == "speed" then self.Sprint = bool_to_num end
	elseif binding == "walk" then self.Walk = bool_to_num end
	elseif binding == "jump" then self:SetJump(is_pressed) end
	elseif binding == "attack" then self:SetAttack(is_pressed) end
	elseif binding == "attack2" then self:SetAttack2(is_pressed) end
	
	--Toggles go here
	if is_pressed then
		if binding == "reload" then self:SetOn(not self:GetOn()) end
		elseif binding == "impulse 100" then self:SetLightsOn(not self:SetLightsOn()) end
	end
	
	self:SetWS(self.Fwd - self.Bck)
	self:SetAD(self.Left - self.Right)
	self:SetSprintWalk(1 + math.max((self.Sprint - self.Walk) * self.Boost_Multiplier, -0.8))
end

function ENT:InitInputs()
	self.Fwd = 0
	self.Bck = 0
	self.Left = 0
	self.Right = 0
	self.Sprint = 0
	self.Walk = 0
	self.Walk = 0
	
	self:SetJump(false)
	self:SetAttack(false)
	self:SetAttack2(false)
	self:SetWS(0)
	self:SetAD(0)
	self:SetSprintWalk(0)
	if hook.GetTable()["KeyPress"][tag] then return end

	hook.Add("sushi_buttons", tag, handle_inputs)
end

function ENT:ResetInputs()
	self.Fwd = 0
	self.Bck = 0
	self.Left = 0
	self.Right = 0
	self.Sprint = 0
	self.Walk = 0
	self.Walk = 0
	
	self:SetJump(false)
	self:SetAttack(false)
	self:SetAttack2(false)
	self:SetWS(0)
	self:SetAD(0)
	self:SetSprintWalk(0)
end