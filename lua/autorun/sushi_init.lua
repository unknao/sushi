sushi = sushi or {}

local LoadFolder(path, realm)
	local realm = realm or "shared"
	local files=file.Find(path.."*.lua", "LUA")
	
	for k, v in pairs(files) do
		if realm ~= "server" then AddCSLuaFile(path..v) end
		if realm == "client" and SERVER then continue end
		if realm == "server" and CLIENT then continue end
		
		include(path..v)
	end
end

hook.Add("InitPostEntity", "sushi_init", function()
	--Shared
	LoadFolder("sushi/")

	--Server
	LoadFolder("sushi/", "client")

	--Client
	LoadFolder("sushi/", "server")
end)


