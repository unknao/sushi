function sushi.FindAvailableSeat(veh)
	if not veh.IsSushiBase then return end
	local result
	
	for i, v in ipairs(veh.Seats) do
		if not IsValid(v:GetDriver()) then 
			result = v
		end
	end
	
	return result
end

function sushi.MusicalChairs(ply, veh, num)
	if not veh.IsSushiBase then return end
	
	local seat = veh.Seats[num]
	if not IsValid(seat) then return end
	if IsValid(seat:GetDriver()) then return end
	
	ply:EnterVehicle(seat)
end