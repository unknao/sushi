local block_controls = "sushi_blockcontrols"
local lookup_binds = {
	"impulse 100",
	"attack",
	"attack2",
	"forward",
	"back",
	"left",
	"right",
	"jump",
	"reload",
	"speed",
	"walk",
}

if SERVER then
	util.AddNetworkString("sushi_sync_binds")
	util.AddNetworkString(block_controls)
	
	net.Receive("sushi_sync_binds", function(_ ply)
		ply.sushi.synced_bindings = net.ReadTable()
	end)
	
	net.Receive("sushi_blockcontrols", function(_ ply)
		ply.sushi.blockcontrols = net.ReadBool()
	end)

	hook.Add("PlayerButtonDown", tag, function(ply, key)
		if ply.sushi.blockcontrols then return end
		local veh = ply:GetVehicle()
		if not IsValid(veh) then return end
		
		local vehbase = veh:GetParent()
		if not IsValid(vehbase) then return end
		if not vehbase.IsSushiBase then return end	
		
		local binding
		--Shift numbers by -1 for seat switching
		if key <=10 then
			key = ((key - 1) % 10) + 1
		else
			if not ply.sushi.synced_bindings[key] then return end
			
			binding = ply.sushi.synced_bindings[key]
		end
		
		hook.Run("sushi_buttons", vehbase, key, binding, true)
	end)	
	
	hook.Add("PlayerButtonUp", tag, function(ply, key)
		local veh = ply:GetVehicle()
		if not IsValid(veh) then return end
		
		local vehbase = veh:GetParent()
		if not IsValid(vehbase) then return end
		if not vehbase.IsSushiBase then return end	
		
		local binding
		--Shift numbers by -1 for seat switching
		if key <=10 then
			key = ((key - 1) % 10) + 1
		else
			if not ply.sushi.synced_bindings[key] then return end
			
			binding = ply.sushi.synced_bindings[key]
		end
		
		hook.Run("sushi_buttons", vehbase, key, binding, false)
	end)
end

if SERVER then return end

hook.Add("InitPostEntity", "sushi_sync_binds", function()
	local tbl = {}
	for i, v in ipairs(lookup_binds) do
		tbl[input.LookupBinding(v)] = v
	end
	
	net.Start("sushi_sync_binds")
	net.WriteTable(tbl)
	net.SendToServer()
end)

--Thank you Simfphys
local function lockControls(lock)
	net.Start(block_controls)
	net.WriteBool(lock)
	net.SendToServer()
end

hook.Add( "OnContextMenuOpen", block_controls, function() lockControls(true) end)
hook.Add( "OnContextMenuClose", block_controls, function() lockControls(false) end)
hook.Add( "OnSpawnMenuOpen", block_controls, function() lockControls(true) end)
hook.Add( "OnSpawnMenuClose", block_controls, function() lockControls(false) end)
hook.Add( "FinishChat", block_controls, function() lockControls(false) end)
hook.Add( "StartChat", block_controls, function() lockControls(true) end)