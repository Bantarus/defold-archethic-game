local component = require("druid.component")
local monarch = require "monarch.monarch"

local game_archethic = require("modules.networking.game_archethic")

---@class component_name : druid.archmon_console
local Component = component.create("archmon_console")

local SCHEME = {
	ROOT = "root",
	BUTTON_FEED = "button_feed",
	BUTTON_HEAL = "button_heal",
	BUTTON_SLEEP = "button_sleep",
	BUTTON_RESURRECT = "button_resurrect"

}

local function on_click_feed()

	-- block button until next game server xp update

	-- play waiting circle flair animation 

	-- send feed call to archethic

	game_archethic.build_network_call_function(game_archethic.api_functions.FEED, {})
	
end

local function on_click_heal()

	-- block button until next game server health update

	-- play waiting circle flair animation 

	-- send heal call to archethic

	game_archethic.build_network_call_function(game_archethic.api_functions.HEAL, {})
	


end

local function on_click_sleep()

	-- block button until next game server energy update

	-- play waiting circle flair animation 

	-- send heal call to archethic

	game_archethic.build_network_call_function(game_archethic.api_functions.SLEEP, {})
	
end


local function on_click_resurrect()

	-- block button until next game server life status update

	-- play waiting circle flair animation 
	
	-- send heal call to archethic

	game_archethic.build_network_call_function(game_archethic.api_functions.RESURRECT, {})
	
	

end

local function display_notification(self)


end



function Component:init(template, nodes)
	self:set_template(template)
	self:set_nodes(nodes)
	self.root = self:get_node(SCHEME.ROOT)
	self.druid = self:get_druid()

	self.button_feed = self.druid:new_button(SCHEME.BUTTON_FEED, on_click_feed)

	self.button_heal = self.druid:new_button(SCHEME.BUTTON_HEAL, on_click_heal)

	self.button_sleep = self.druid:new_button(SCHEME.BUTTON_SLEEP,on_click_sleep)

	self.button_resurrect = self.druid:new_button(SCHEME.BUTTON_RESURRECT,on_click_resurrect)

	
	
	

	


end

function Component:on_remove() end

return Component