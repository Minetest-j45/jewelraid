bedwars = {}

bedwars.storage = minetest.get_mod_storage()

local mp = minetest.get_modpath(minetest.get_current_modname())

dofile(mp .. "/item.lua")
dofile(mp .. "/map.lua")
dofile(mp .. "/team.lua")
dofile(mp .. "/ui.lua")

bedwars.log = function(msg)
	if not msg then return end
	minetest.log("action", "[bedwars] " .. msg)
end

bedwars.log("[bedwars] Loaded mod")