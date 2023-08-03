local tag = "sushi_base_inputs"

ENT.Boost_Multiplier = 1

local function handle_inputs(ply, key, is_pressed)
	local bool_to_num = is_pressed and 1 or 0
	
	--Convert to numerals for easier use with logic
	if key == IN_FORWARD then self.Fwd = bool_to_num end
	if key == IN_BACK then self.Bck = bool_to_num end
	if key == IN_MOVELEFT then self.Left = bool_to_num end
	if key == IN_MOVERIGHT then self.Right = bool_to_num end
	if key == IN_SPEED then self:SetSprint(bool_to_num * self.Boost_Multiplier) end
	
	--Toggle actions go here
	if is_pressed then
		if key == IN_RELOAD then self:SetOn(not self:GetOn()) end
	end
	
	self:SetWS(self.Fwd - self.Bck)
	self:SetAD(self.Left - self.Right)
end

function ENT:InitInputs()
	self.Fwd = 0
	self.Bck = 0
	self.Left = 0
	self.Right = 0
	self.Sprint = 0
	if hook.GetTable()["KeyPress"][tag] then return end
	
	hook.Add("KeyPress", tag, function(ply, key) handle_inputs(ply, key, true) end) 
	hook.Add("KeyRelease", tag, function(ply, key) handle_inputs(ply, key, true) end) 
end

function ENT:ResetInputs()
	self.Fwd = 0
	self.Bck = 0
	self.Left = 0
	self.Right = 0
	
	self:SetWS(0)
	self:SetAD(0)
	self:SetSprint(0)
end