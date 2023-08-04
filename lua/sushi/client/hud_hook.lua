hook.Add("HUDPaint", "HUDSushiPaint", function()
	local veh = ply:GetVehicle()
	if not IsValid(veh) then return end
		
	local vehbase = veh:GetParent()
	if not IsValid(vehbase) then return end
	if not vehbase.IsSushiBase then return end	
	
	hook.Run("HUDSushiPaint")
end)