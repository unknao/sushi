sushi_base_lib = sushi_base_lib or {}

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

--Shared
LoadFolder("sushi_base_lib/")

--Server
LoadFolder("sushi_base_lib/", "client")

--Client
LoadFolder("sushi_base_lib/", "server")


