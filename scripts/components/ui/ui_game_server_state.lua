local component = require("druid.component")
local progress = require ("druid.extended.progress")
local monarch = require "monarch.monarch"
local game_archethic = require("modules.networking.game_archethic")
local local_storage = require("modules.storage.local_storage")
local session_storage = require("modules.storage.session_storage")
local utils = require("modules.common.utils")

---@class component_name : druid.game_server_state
local Component = component.create("game_server_state")

local SCHEME = {
	ROOT = "root",
	TEXT_USERNAME = "text_username",
	TEXT_ARCHMON_NAME = "text_archmon_name",
	HEALTH_BAR  = "health_bar",
	TEXT_HEALTH = "text_health",
	XP_BAR = "xp_bar",
	TEXT_XP = "text_xp",
	TEXT_LEVEL = "text_level",
	TEXT_POWER = "text_power",
	TEXT_LAST_UPDATE = "text_last_update",
	
}

-- game server state consumer 
local function display_game_server_state(self)


	print("display game server update ")

	local health_pct_value = math.floor(self.player_info.archmon.health / self.player_info.archmon.base_health * 100 ) / 100
	
	self.health_bar:to(health_pct_value)
	local text_health = self.player_info.archmon.health .. "/" .. self.player_info.archmon.base_health
	gui.set_text(self.text_health.node,text_health )

	
	gui.set_text(self.text_power.node, self.player_info.archmon.power)

	local xp_pct_value = math.floor(self.player_info.archmon.xp / (self.player_info.archmon.level * 20 ) * 100 ) / 100
	print("bar xp pct value is : " .. xp_pct_value )

	self.xp_bar:to(xp_pct_value)  
	
	local text_xp = self.player_info.archmon.xp .. "/" .. self.player_info.archmon.level * 20
	gui.set_text(self.text_xp.node, text_xp)

	local text_level = "L." .. self.player_info.archmon.level

	gui.set_text(self.text_level.node, text_level)

	-- energy grid filling

	local energy_filler_up_to = self.player_info.archmon.energy
	for i = 1, 5 do

		if i <= energy_filler_up_to then
			gui.set_enabled(self.energy_grid_slots[i][self:get_template() .. "/energy_slot_fill"],true)

		else
			gui.set_enabled(self.energy_grid_slots[i][self:get_template() .. "/energy_slot_fill"],false)
		end
	end

end

-- game server producer
local produce_game_server_state  = coroutine.create(
function(self)

	print("hello from coroutine")

	local current_value = self.player_info
	local session_decoded_value = {}

while true do

	session_decoded_value = json.decode(session_storage.get_item(game_archethic.api_functions[api_key]))

	if session_decoded_value ~= nil and not utils.deepCompare(session_decoded_value,current_value) then 
	
		coroutine.yield(session_decoded_value) 

	end

end

end)

local function update_game_server_state(self,api_key, force)

	local session_decoded_value = {}
	local current_value = self.player_info
	--print("update_game_server_state , current value : " .. json.encode(current_value))

	if force then
		
		local status, value = coroutine.resume(produce_game_server_state,self,api_key)


		

		session_decoded_value = value
		

	else 

		print ("api_key : " .. game_archethic.api_functions[api_key])

		session_decoded_value = json.decode(session_storage.get_item(game_archethic.api_functions[api_key]))


	end

	
	--print("session_decoded_value : " .. json.encode(session_decoded_value)  ) 
	

	if session_decoded_value ~= nil and not utils.deepCompare(session_decoded_value,current_value) then

		if api_key == "GET_PLAYER_INFO" then
			self.player_info = session_decoded_value
			display_game_server_state(self)
			local_storage.set_player_info(self.player_info)
			msg.post(".", "player_info_updated")

		end
	end
	

end


local function add_node(self, index)
	local prefab = gui.get_node(self:get_template() .. "/energy_slot_prefab")
	local cloned = gui.clone_tree(prefab)
	gui.set_enabled(cloned[self:get_template() .. "/energy_slot_prefab"], true)
	self.energy_grid:add(cloned[self:get_template() .. "/energy_slot_prefab"], index)
	table.insert(self.energy_grid_slots,cloned)
end





function Component:init(template, nodes)
	self:set_template(template)
	self:set_nodes(nodes)
	self.root = self:get_node(SCHEME.ROOT)
	self.druid = self:get_druid()


	self.tick_counter = 0
	self.player_genesis_address = local_storage.get_public_address()

	print("public address : " .. self.player_genesis_address )

	
	self.text_username = self.druid:new_text("text_username",local_storage.get_username() )

	self.text_archmon_name = self.druid:new_text("text_archmon_name","ARCHMON")

	

	self.text_level = self.druid:new_text("text_level","L.1") --,"L." .. self.player_info.archmon.level)
	
	
	self.health_bar = self.druid:new(progress,"health_fill_x","x", 1)
	self.text_health = self.druid:new_text("text_health", "10/10" )
	self.health_bar.on_change:subscribe(function(_, value)

		gui.set_text(self.text_health.node, self.player_info.archmon.health .. "/" .. self.player_info.archmon.base_health)
		
	end)
	
	self.text_power =  self.druid:new_text("text_power","2")
	
	
	
	self.xp_bar = self.druid:new(progress,"xp_fill_x","x", 0)
	self.xp_bar.on_change:subscribe(function(_, value)
		
	
		gui.set_text(self.text_xp.node, self.player_info.archmon.xp .. "/" .. self.player_info.archmon.level * 20 )
	end)

	self.text_xp = self.druid:new_text("text_xp","0/20")
	

	-- energy bar as static grid


	self.energy_grid = self.druid:new_static_grid("energy_grid_content", "energy_slot_prefab", 5)
	:set_position_function(simple_animate)

	gui.set_enabled(gui.get_node(self:get_template() .. "/energy_slot_prefab"), false)

	self.energy_grid_slots = {}
	for i = 1, 5 do
		add_node(self, i)
	end

	

	-- init game server status gui with local player info if exist
	self.player_info = local_storage.get_player_info()
	
	if self.player_info~= nil then 
		
		gui.set_text(self.text_level.node,"L." .. self.player_info.archmon.level)
		local health_bar_init_value = self.player_info.archmon.health / self.player_info.archmon.base_health
		self.health_bar:to(health_bar_init_value)
		local text_health = self.player_info.archmon.health .. "/" .. self.player_info.archmon.base_health
		
		gui.set_text(self.text_health.node, text_health)
		gui.set_text(self.text_power.node,self.player_info.archmon.power)
		
		local xp_bar_init_value = math.floor(self.player_info.archmon.xp / (self.player_info.archmon.level * 20 ) * 100 ) / 100
		self.xp_bar:set_to(xp_bar_init_value)
		gui.set_text(self.text_xp.node, self.player_info.archmon.xp .. "/" .. self.player_info.archmon.level * 20)

		-- energy grid filling

		local energy_filler_up_to = self.player_info.archmon.energy

		for i = 1, 5 do

			if i <= energy_filler_up_to then
				gui.set_enabled(self.energy_grid_slots[i][self:get_template() .. "/energy_slot_fill"],true)
				
			else
				gui.set_enabled(self.energy_grid_slots[i][self:get_template() .. "/energy_slot_fill"],false)
			end
		end
		
	end

	msg.post(".", "game_server_gui_ready")
	
	-- call player server state update
	local call_args = {self.player_genesis_address}

	game_archethic.build_network_call_function(game_archethic.api_functions.GET_PLAYER_INFO,call_args )

	update_game_server_state(self,"GET_PLAYER_INFO",false)

end

function Component:on_remove() end

function Component:update(dt) 

	self.tick_counter = self.tick_counter + dt


	-- update player server state every 10 seconds

	if self.tick_counter >= 10.0 then 
		-- send a call to archethic to update the session item "get_player_info"
		local call_args = {self.player_genesis_address}
		game_archethic.build_network_call_function(game_archethic.api_functions.GET_PLAYER_INFO, call_args)

		
		update_game_server_state(self,"GET_PLAYER_INFO",false)

		self.tick_counter = 0
	end




end

function Component:on_message(message_id, message, sender) 

	if message_id == hash("game_server_gui_ready") then

		-- call player server state update
		local call_args = {self.player_genesis_address}

		game_archethic.build_network_call_function(game_archethic.api_functions.GET_PLAYER_INFO,call_args )
		

		update_game_server_state(self,"GET_PLAYER_INFO", false)


	end

end

return Component