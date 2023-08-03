local tag = "sushi_base_handlecontrols"

local networked_binds = {
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
	util.AddNetworkString("sushi_base_sync_binds")
	util.AddNetworkString("sushi_base_blockcontrols")
	
	net.Receive("sushi_base_blockcontrols", function(_ ply)
		ply.sushi_blockcontrols = net.ReadBool()
	end)

	hook.Add("PlayerButtonDown", tag, function(ply, btn)
		if ply.sushi_blockcontrols then return end
		local veh = ply:GetVehicle()
		if not IsValid(veh) then return end
		
		local vehbase = veh:GetParent()
		if not IsValid(vehbase) then return end
		if not vehbase.IsSushiBase then return end	
		
		if btn <=10 then
			btn = ((btn - 1) % 10) + 1
		else
			
		end
		
	end)
end

if SERVER then return end

local unnetworked_binds = {
	"invprev",
	"invnext",
	"duck",
	"zoom"
}