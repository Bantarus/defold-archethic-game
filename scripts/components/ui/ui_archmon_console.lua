local component = require("druid.component")
local monarch = require "monarch.monarch"
local local_storage = require("modules.storage.local_storage")

local game_archethic = require("modules.networking.game_archethic")
local camera = require "orthographic.camera"

local utils = require("modules.common.utils")

---@class component_name : druid.archmon_console
local Component = component.create("archmon_console")

local SCHEME = {
	ROOT = "root",
	BUTTON_FEED = "button_feed",
	TEXT_BUTTON_FEED = "text_button_feed",
	BUTTON_HEAL = "button_heal",
	TEXT_BUTTON_HEAL = "text_button_heal",
	BUTTON_SLEEP = "button_sleep",
	TEXT_BUTTON_SLEEP = "text_button_sleep",
	BUTTON_RESURRECT = "button_resurrect",
	TEXT_BUTTON_RESURRECT = "text_button_resurrect"
	

}



local function co_check_key_update(self, key, current_value)

	print("hello from home console coroutine")

	
	local storage_value = {}

	while true do

		local storage_value = local_storage.get_player_info()[key]
		
		if storage_value ~= nil and not storage_value == current_value then 

			coroutine.yield(storage_value) 

		end
		

	end

end

local function check_key_update(self,key,current_value)

	print("check key update : " .. key .. "," .. current_value)

	local storage_value = local_storage.get_player_info().archmon[key]
	print("storage_value : " .. storage_value)

	return storage_value ~= nil and storage_value ~= current_value

end



local function on_click_feed(self, args, button)

	-- disable button until next game server xp update

	button:set_input_enabled(false)

	-- hide button text
	gui.set_enabled(self.text_button_feed.node, false)

	print("position button_feed : " .. gui.get_screen_position(self.button_feed.node))
	print("button node position : " .. gui.get_screen_position(button.node))
	print("camera scenn to world : " .. camera.screen_to_world(nil, gui.get_screen_position(self.button_feed.node))  )
	
	
	-- play waiting circle flair animation at button position
	
	local cloned_prefab = gui.clone_tree(gui.get_node(self:get_template() .. "/prefab_flair_circle_animation"))
	gui.set_position(cloned_prefab[self:get_template() .. "/prefab_flair_circle_animation"], gui.get_position(gui.get_node(self:get_template() .. "/box_feed")))
	gui.set_enabled(cloned_prefab[self:get_template() .. "/prefab_flair_circle_animation"], true)
	gui.play_flipbook(cloned_prefab[self:get_template() .. "/prefab_flair_circle_animation"], "flair_circle", nil, { playback_rate = 0.1 })
	

	-- keep track of current affected values
	local player_info = local_storage.get_player_info()
	self.xp_before_feed = player_info.archmon.xp
	self.level_before_feed = player_info.archmon.level

	
	-- send feed call to archethic

	game_archethic.send_transfer_transaction(game_archethic.api_functions.FEED, {})

	self.feed_flair_cycle_cloned_prefab = cloned_prefab
	self.is_feeding = true
	
	
	
end

local function on_click_heal(self,args, button)

	-- disable button until next game server xp update

	button:set_input_enabled(false)

	-- hide button text
	gui.set_enabled(self.text_button_heal.node, false)

	
	-- play waiting circle flair animation at button position

	local cloned_prefab = gui.clone_tree(gui.get_node(self:get_template() .. "/prefab_flair_circle_animation"))
	gui.set_position(cloned_prefab[self:get_template() .. "/prefab_flair_circle_animation"], gui.get_position(gui.get_node(self:get_template() .. "/box_heal")))
	gui.set_enabled(cloned_prefab[self:get_template() .. "/prefab_flair_circle_animation"], true)
	gui.play_flipbook(cloned_prefab[self:get_template() .. "/prefab_flair_circle_animation"], "flair_circle", nil, { playback_rate = 0.1 })


	-- keep track of current affected values
	local player_info = local_storage.get_player_info()
	self.health_before_heal = player_info.archmon.health


	-- send feed call to archethic

	game_archethic.send_transfer_transaction(game_archethic.api_functions.HEAL, {})

	self.heal_flair_cycle_cloned_prefab = cloned_prefab
	self.is_healing = true

	

end

local function on_click_sleep(self,args,button)

	-- disable button until next game server xp update

	button:set_input_enabled(false)

	-- hide button text
	gui.set_enabled(self.text_button_sleep.node, false)

	

	-- play waiting circle flair animation at button position

	local cloned_prefab = gui.clone_tree(gui.get_node(self:get_template() .. "/prefab_flair_circle_animation"))
	gui.set_position(cloned_prefab[self:get_template() .. "/prefab_flair_circle_animation"], gui.get_position(gui.get_node(self:get_template() .. "/box_sleep")))
	gui.set_enabled(cloned_prefab[self:get_template() .. "/prefab_flair_circle_animation"], true)
	gui.play_flipbook(cloned_prefab[self:get_template() .. "/prefab_flair_circle_animation"], "flair_circle", nil, { playback_rate = 0.1 })


	-- keep track of current affected values
	local player_info = local_storage.get_player_info()
	self.energy_before_sleep = player_info.archmon.energy


	-- send feed call to archethic

	game_archethic.send_transfer_transaction(game_archethic.api_functions.REFRESH_ACTION_POINTS, {})

	self.sleep_flair_cycle_cloned_prefab = cloned_prefab
	self.is_sleeping = true
	
	
end


local function on_click_resurrect(self,args, button)

	-- disable button until next game server xp update

	button:set_input_enabled(false)

	-- hide button text
	gui.set_enabled(self.text_button_resurrect.node, false)



	-- play waiting circle flair animation at button position

	local cloned_prefab = gui.clone_tree(gui.get_node(self:get_template() .. "/prefab_flair_circle_animation"))
	gui.set_position(cloned_prefab[self:get_template() .. "/prefab_flair_circle_animation"], gui.get_position(gui.get_node(self:get_template() .. "/box_resurrect")))
	gui.set_enabled(cloned_prefab[self:get_template() .. "/prefab_flair_circle_animation"], true)
	gui.play_flipbook(cloned_prefab[self:get_template() .. "/prefab_flair_circle_animation"], "flair_circle", nil, { playback_rate = 0.1 })


	-- keep track of current affected values
	local player_info = local_storage.get_player_info()
	self.health_before_resurrect = player_info.archmon.health


	-- send feed call to archethic

	game_archethic.send_transfer_transaction(game_archethic.api_functions.RESURRECT, {})

	self.resurrect_flair_cycle_cloned_prefab = cloned_prefab
	self.is_resurrecting = true

	

end

local function display_notification(self,message)


end



function Component:init(template, nodes)
	self:set_template(template)
	self:set_nodes(nodes)
	self.root = self:get_node(SCHEME.ROOT)
	self.druid = self:get_druid()

	self.button_feed = self.druid:new_button(SCHEME.BUTTON_FEED, on_click_feed)
	self.text_button_feed = self.druid:new_text(SCHEME.TEXT_BUTTON_FEED)
	self.button_feed_is_waiting = false

	self.button_heal = self.druid:new_button(SCHEME.BUTTON_HEAL, on_click_heal)
	self.text_button_heal = self.druid:new_text(SCHEME.TEXT_BUTTON_HEAL)

	self.button_sleep = self.druid:new_button(SCHEME.BUTTON_SLEEP,on_click_sleep)
	self.text_button_sleep = self.druid:new_text(SCHEME.TEXT_BUTTON_SLEEP)

	self.button_resurrect = self.druid:new_button(SCHEME.BUTTON_RESURRECT,on_click_resurrect)
	self.text_button_resurrect = self.druid:new_text(SCHEME.TEXT_BUTTON_RESURRECT)

	
	
	

	


end

function Component:on_message(message_id, message, sender) 

	if message_id == hash("player_info_updated") then
		print("message player_info_updated  in home ")

		if self.is_feeding then

			if check_key_update(self, "xp", self.xp_before_feed) or check_key_update(self, "level", self.level_before_feed) then

				-- when update then 

				gui.delete_node(self.feed_flair_cycle_cloned_prefab[self:get_template() .. "/prefab_flair_circle_animation"])


				-- show button text
				gui.set_enabled(self.text_button_feed.node, true)

				-- enable back input
				self.button_feed:set_input_enabled(true)

				self.is_feeding = false

			end


		end


		if self.is_healing then

			if check_key_update(self, "health", self.health_before_heal) then

				-- when update then 

				print("health updated")

				gui.delete_node(self.heal_flair_cycle_cloned_prefab[self:get_template() .. "/prefab_flair_circle_animation"])


				-- show button text
				gui.set_enabled(self.text_button_heal.node, true)

				-- enable back input
				self.button_heal:set_input_enabled(true)

				self.is_healing = false

			end
		end


		if self.is_sleeping then


			if check_key_update(self, "energy", self.energy_before_sleep) then

				-- when update then 

				gui.delete_node(self.sleep_flair_cycle_cloned_prefab[self:get_template() .. "/prefab_flair_circle_animation"])


				-- show button text
				gui.set_enabled(self.text_button_sleep.node, true)

				-- enable back input
				self.button_sleep:set_input_enabled(true)

				self.is_sleeping = false
				
			end


		end

		if self.is_resurrecting then
			if check_key_update(self, "health", self.health_before_resurrect) then

				-- when update then 

				gui.delete_node(self.resurrect_flair_cycle_cloned_prefab[self:get_template() .. "/prefab_flair_circle_animation"])


				-- show button text
				gui.set_enabled(self.text_button_resurrect.node, true)

				-- enable back input
				self.button_resurrect:set_input_enabled(true)

				self.is_resurrecting = false


			end

		end

	end
end

function Component:on_remove() end

return Component