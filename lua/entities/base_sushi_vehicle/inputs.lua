local tag = "sushi_base_inputs"

ENT.Boost_Multiplier = 1

local function handle_inputs(veh, ply, key, binding, is_pressed)
	--If keys are numbers, attempt to change seats.
	if key <= 10 then sushi.MusicalChairs(ply, veh, key) return end
	
	--Convert to numerals for easier use with logic
	local bool_to_num = is_pressed and 1 or 0
	if binding == "forward" then veh.Fwd = bool_to_num end
	elseif binding == "back" then veh.Bck = bool_to_num end
	elseif binding == "left" then veh.Left = bool_to_num end
	elseif binding == "right" then veh.Right = bool_to_num end
	elseif binding == "speed" then veh.Sprint = bool_to_num end
	elseif binding == "walk" then veh.Walk = bool_to_num end
	elseif binding == "jump" then veh:SetJump(is_pressed) end
	elseif binding == "attack" then veh:SetAttack(is_pressed) end
	elseif binding == "attack2" then veh:SetAttack2(is_pressed) end
	
	--Toggles go here
	if is_pressed then
		if binding == "reload" then veh:SetOn(not veh:GetOn()) end
		elseif binding == "impulse 100" then veh:SetLightsOn(not veh:SetLightsOn()) end
	end
	
	veh:SetWS(veh.Fwd - veh.Bck)
	veh:SetAD(veh.Left - veh.Right)
	veh:SetSprintWalk(1 + math.max((veh.Sprint - veh.Walk) * veh.Boost_Multiplier, -0.8))
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
	if hook.GetTable()["sushi_buttons"][tag] then return end

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