bedwars.events = {300, 300, 300, 300, 600, 600, 600, 600}
bedwars.event_list = {"dia2", "mese2", "dia3", "mese3", "bed", "game_end"}
bedwars.event_msg = {
	"Diamond generators have been upgraded to Tier 2",
	"Mese generators have been upgraded to Tier 2",
	"Diamond generators have been upgraded to Tier 3",
	"Mese generators have been upgraded to Tier 3",
	"All beds have been destroyed",
	"Game has ended",
}
bedwars.next_event_msg = {
	"Diamond upgrade",
	"Mese upgrade",
	"Diamond maxed",
	"Mese maxed",
	"Bed destruction",
	"Game ends",
}
bedwars.event = 0

bedwars.event_timer_start = function()
	bedwars.timer = 0
	minetest.register_globalstep(function(dtime)
		bedwars.timer = bedwars.timer + dtime
		if bedwars.timer >= bedwars.events[bedwars.event + 1] then
			bedwars.event = bedwars.event + 1
			minetest.chat_send_all(bedwars.event_msg[bedwars.event])
			bedwars.timer = 0
			
			if bedwars.event_list[bedwars.event] == "bed" then
				bedwars.beds = {red = false, green = false, blue = false, yellow = false}
				minetest.sound_play("bed_destruction", {
					to_player = minetest.get_connected_players()[1],
					gain = 2.0,
				})
			end
			if bedwars.event_list[bedwars.event] == "game_end" then
				minetest.request_shutdown("Game has ended", false, 1)
			end
		end
		if bedwars.event_list[bedwars.event] ~= "game_end" then
			bedwars.ui_update()
		end
	end)
end
