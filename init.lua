bedwars = {}

bedwars.init = false

bedwars.storage = minetest.get_mod_storage()

local mp = minetest.get_modpath(minetest.get_current_modname())

bedwars.log = function(msg)
	if not msg then return end
	minetest.log("action", "[bedwars] " .. msg)
end

dofile(mp .. "/map.lua")

local maps = {}
for _, map in ipairs(bedwars.maps) do
	table.insert(maps, map.name)
end

if #maps > 0 then
	dofile(mp .. "/shop.lua")
	dofile(mp .. "/team.lua")
	dofile(mp .. "/ui.lua")
	dofile(mp .. "/bed.lua")
	dofile(mp .. "/event.lua")
	dofile(mp .. "/forge.lua")
	dofile(mp .. "/dragon.lua")
	dofile(mp .. "/chest.lua")
	
	math.randomseed(os.clock())
	bedwars.current_map = maps[math.random(1, #maps)]
	
	minetest.register_on_joinplayer(function(player)
		if not bedwars.init then
			bedwars.init = true
			bedwars.event_timer_start()
			minetest.clear_objects({mode = "quick"})
			for _, attr in pairs(bedwars.get_map_by_name(bedwars.current_map)) do
				local centre = minetest.string_to_pos(attr) or player:get_pos()
				for x = centre.x - 30, centre.x + 30 do
					for y = centre.y - 30, centre.y + 30 do
						for z = centre.z - 30, centre.z + 30 do
							local pos = {x = x, y = y, z = z}
							local node = minetest.get_node(pos)
							if node.name:find("wool:", nil, true) or node.name == "default:tinblock" or node.name == "default:wood" then
								minetest.set_node(pos, {name = "air"})
							end
						end
					end
				end
			end
		end
		local inv = player:get_inventory()
		for k, v in pairs(inv:get_lists()) do
			inv:set_list(k, {})
		end
	end)
	
	minetest.register_on_dieplayer(function(player)
		local inv = player:get_inventory()
		for k, v in pairs(inv:get_lists()) do
			for _, itemstack in ipairs(v) do
				minetest.add_item(player:get_pos(), itemstack)
			end
		end
		for k, v in pairs(inv:get_lists()) do
			if k ~= "ec" then
				inv:set_list(k, {})
			end
		end
	end)
end

bedwars.log("Loaded mod")
