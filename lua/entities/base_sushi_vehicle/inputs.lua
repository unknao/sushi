local tag = "sushi_base_inputs"

ENT.Boost_Multiplier = 1

local function handle_inputs(veh, ply, key, binding, is_pressed)
	--If keys are numbers, attempt to change seats.
	if key <= 10 then sushi.MusicalChairs(ply, veh, key) return end
	
	--Convert to numerals for easier use with logic
	local bool_to_num = is_pressed and 1 or 0
	if binding == "forward" then veh.Fwd = bool_to_num
		elseif binding == "back" then veh.Bck = bool_to_num
		elseif binding == "left" then veh.Left = bool_to_num
		elseif binding == "right" then veh.Right = bool_to_num
		elseif binding == "speed" then veh.Sprint = bool_to_num
		elseif binding == "walk" then veh.Walk = bool_to_num
		elseif binding == "jump" then veh:SetJump(is_pressed)
		elseif binding == "attack" then veh:SetAttack(is_pressed)
		elseif binding == "attack2" then veh:SetAttack2(is_pressed) 
	end
	
	--Toggles go here
	if is_pressed then
		if binding == "reload" then veh:SetOn(not veh:GetOn())
			elseif binding == "impulse 100" then veh:SetLightsOn(not veh:SetLightsOn()) 
		end
	end
	
	veh:SetWS(veh.Fwd - veh.Bck)
	veh:SetAD(veh.Left - veh.Right)
	veh:SetSprintWalk(1 + math.max((veh.Sprint - veh.Walk) * veh.Boost_Multiplier, -0.8))
end

function ENT:SetupInputs()
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

hook.Add("PlayerEnteredVehicle", tag , function(ply, veh)
	local vehbase = veh:GetParent()
	if not IsValid(vehbase) then return end
	if not vehbase.IsSushiBase then return end
	
	if veh == vehbase.Seats[1] then
		vehbase:SetDriver(ply)
	end
end)

hook.Add("PlayerLeaveVehicle", tag , function(ply, veh)
	local vehbase = veh:GetParent()
	if not IsValid(vehbase) then return end
	if not vehbase.IsSushiBase then return end
	
	if veh == vehbase.Seats[1] then
		vehbase:SetDriver(NULL)
		self:ResetInputs()
	end
end)

function ENT:Use(ply)
	local chosen_seat = sushi.FindAvailableSeat(self)
	if not IsValid(chosen_seat) then return end

	ply:EnterVehicle(chosen_seat)
end				