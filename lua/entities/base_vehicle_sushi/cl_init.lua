hook.Add("CalcVehicleView", "sushi_base_thirdperson", function(veh, ply, view)
	if not veh:GetThirdPersonMode() then return end
	
	local vehbase = veh:GetParent()
	if not IsValid(vehbase) then return end
	if not vehbase.SushiBase then return end
	
	local tr = util.TraceHull({
		start = view.origin,
		endpos = view.origin - view.angles:Forward() * (50 + veh:GetCameraDistance() * 50),
		filter = vehbase:GetChildren(),
		mins = Vector(-4, -4, -4),
		maxs = Vector(4, 4, 4),
		mask = MASK_SOLID,
		collisiongroup = COLLISION_GROUP_WEAPON
	})
	
	view.drawviewer = true
	view.origin = tr.HitPos
	return view
end)