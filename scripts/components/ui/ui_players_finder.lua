local component = require("druid.component")
local monarch = require "monarch.monarch"
local game_archethic = require("modules.networking.game_archethic")
local session_storage = require("modules.storage.session_storage")
local data_list = require("druid.extended.data_list")
local archmon_card = require("scripts.components.ui.ui_archmon_card")

---@class component_name : druid.players_finder
local Component = component.create("players_finder")

local SCHEME = {
	ROOT = "root",
	PREFAB_BUTTON_FIGHT = "prefab_button_fight",
	SCROLL = "scroll",
	GRID ="grid",
	PREFAB = "prefab",
	DATA_LIST = "data_list",

}

local function on_click_fight(self,args,button)

	

	print("click fight for :  " .. json.encode(args.data))

	msg.post(".", "button_fight_clicked", { data = args.data })

	-- show pop fight confirmation
	-- monarch.show(hash("pop_play_confirm_fight"), nil , args)

	-- force update ( wait for fight sequence )


	-- show game with fight data ( resolved onchain)

	-- monarch.show(hash("game"), nil , {figh_sequence_info = figh_sequence_info}})

end


local function create_element(self,data, index,data_list)

	local instance = gui.clone_tree(self.prefab)
	-- print(" prefab clone instance : " .. json.encode(instance))
	print(" data : " .. json.encode(data))
	-- gui.set_enabled(instance[self:get_template() .. "/prefab_card_content"], true)
	gui.set_enabled(instance[self:get_template() .. "/finder_archmon_card/root"], true)
	-- gui.set_text(instance[self:get_template() .. "/text_username"], data.username)
	
	local archmon_card = self.druid:new(archmon_card,"finder_archmon_card/prefab_archmon_card", instance, data.player_info.archmon)

-- 	-- attach button_fight
	local button_fight_args = {data = data }
	local button_fight = self.druid:new_button(instance[self:get_template() .. "/finder_archmon_card/prefab_button_fight"], on_click_fight,button_fight_args )

	print("finder_archmon_card size : " .. json.encode(gui.get_size(instance[self:get_template() .. "/finder_archmon_card/root"])))
	button_fight:set_click_zone(data_list.scroll.view_node)
	
	
-- 	return instance[self:get_template() .. "/prefab_card_content"], button_fight
return instance[self:get_template() .. "/finder_archmon_card/root"], button_fight

end

function Component:init(template, nodes)
	self:set_template(template)
	self:set_nodes(nodes)
	self.root = self:get_node(SCHEME.ROOT)
	self.druid = self:get_druid()

	self.tick_counter = 0

	gui.set_enabled(self.root, true)
	
	--self.button_fight = self.druid:new_button(SCHEME.BUTTON_FIGHT, on_click_fight)

	self.scroll = self.druid:new_scroll("grid_view","grid_content")
	self.scroll:set_vertical_scroll(false)

	self.grid = self.druid:new_static_grid("grid_content","finder_archmon_card/root", 99)

	-- self.grid.on_add_item:subscribe(function(_, node, index)
	-- 	print("add_item : " .. index )
	-- 	print("position : " .. gui.get_position(node))
	-- end)
	
	self.prefab = gui.get_node(template .. "/finder_archmon_card/root")
	-- self.prefab = gui.get_node(template .. "/prefab_card_content")

	--gui.set_enabled(self.prefab, false)


	self.data_list = self.druid:new(data_list,self.scroll, self.grid, create_element)
	
	self.players = json.decode(session_storage.get_item("get_players"))

	-- if players nil wait for session item get_players update
	
	pprint("players : " .. json.encode(self.players))
	-- if profile contain saved squads then they are added to the decks inventory data table 

	-- init data table 
	local players_table = {}
	
	if self.players then 
		for k, v in pairs(self.players) do

			table.insert(players_table, {player_genesis_address = k , player_info = v})

		end

		self.data_list:set_data(players_table)

	
		self.scroll:scroll_to_index(1)
		

	else 

		
		self.is_waiting = true
		
		
	end

	local call_args = {}
	game_archethic.build_network_call_function(game_archethic.api_functions.GET_PLAYERS, call_args)

	print("Players finder initialized !")

end

function Component:update(dt) 

	self.tick_counter = self.tick_counter + dt


	-- update players state every 10 seconds

	if self.tick_counter >= 10.0 then 
		-- send a call to archethic to update the session item "get_player_info"
		local call_args = {}
		game_archethic.build_network_call_function(game_archethic.api_functions.GET_PLAYERS, call_args)


		session_storage.check_update(self, "GET_PLAYERS", self.players , 
		function(updated_players) 
			local players_table = {}
			self.data_list_node_positons = {}
			
			self.players = updated_players
			print("updated players : " .. json.encode(updated_players))
			for k, v in pairs(updated_players) do

				table.insert(players_table, {player_genesis_address = k , player_info = v})

			end
			print("players table : " .. json.encode(players_table))
			self.data_list:set_data(players_table)
			self.scroll:scroll_to_index(1)
			
			
			msg.post(".", "players_updated")
			
		end, false)

		self.tick_counter = 0
	end




end

function Component:on_remove() end

return Component