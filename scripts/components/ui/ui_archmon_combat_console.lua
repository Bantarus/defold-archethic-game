local component = require("druid.component")
local battle_round_card = require("scripts.components.ui.ui_battle_round_card")

---@class component_name : druid.archmon_combat_console
local Component = component.create("archmon_combat_console")

local SCHEME = {
	ROOT = "root",
	BUTTON_END = "button_end",
	BUTTON_NEXT_ROUND = "button_next_round",
	BUTTON_NEXT_END = "button_next_end",
	BUTTON_PREVIOUS_ROUND = "button_previous_round",
	BUTTON_PAUSE = "button_pause"
}


local function on_click_end()

	msg.post(".", "battle_end")
	

end

local function on_click_next_round(self, args, button)

	
	self.scroll:scroll_to_index(self.scroll.selected - 1 )

	

	print("click next round : " .. self.battle_info.round_number - self.scroll.selected  + 1)

	local index = self.battle_info.round_number - self.scroll.selected  + 1

	local round_number_node = gui.get_node(self:get_template() .. "/" .. "screen_round")

	gui.play_flipbook(round_number_node, "number_" .. index)

	self.player_total_damage = self.player_total_damage + self.battle_info.player_battle_sequence[index].damage_done
	self.opponent_total_damage = self.opponent_total_damage + self.battle_info.opponent_battle_sequence[index].damage_done


	gui.set_text(self.text_player_total_damage.node, self.player_total_damage) 
	gui.set_text(self.text_opponent_total_damage.node, self.opponent_total_damage)
	
	msg.post(".", "play_battle_round", {index = index} )

	-- if last round change button next to button quit
	if index == self.battle_info.round_number then

		gui.set_enabled(self.button_next_round.node, false)
		gui.set_enabled(self.button_next_end.node, true)

	end

	

end

local function on_click_previous_round(self, args, button)



	self.scroll:scroll_to_index(self.scroll.selected + 1 )
	

end

local function on_click_pause(self, args, button)



end

local function on_click_change_speed(self, args, button)


end



function Component:init(template, nodes, battle_round_card_node_id, battle_info)
	self:set_template(template)
	self:set_nodes(nodes)
	self.root = self:get_node(SCHEME.ROOT)
	self.druid = self:get_druid()

	print("battle info : " .. json.encode(battle_info))
	self.battle_info = battle_info
	self.player_total_damage = self.battle_info.player_battle_sequence[1].damage_done
	self.opponent_total_damage = self.battle_info.opponent_battle_sequence[1].damage_done
	self.text_player_total_damage = self.druid:new_text("text_player_screen_score",self.player_total_damage)
	self.text_opponent_total_damage = self.druid:new_text("text_opponent_screen_score",self.opponent_total_damage)
	
	self.button_end = self.druid:new_button(SCHEME.BUTTON_END, on_click_end)

	self.button_next_round = self.druid:new_button(SCHEME.BUTTON_NEXT_ROUND, on_click_next_round)
	self.button_next_end = self.druid:new_button(SCHEME.BUTTON_NEXT_END, on_click_end)
	self.button_previous_round = self.druid:new_button(SCHEME.BUTTON_PREVIOUS_ROUND, on_click_previous_round)
	
	self.button_pause = self.druid:new_button(SCHEME.BUTTON_PAUSE, on_click_pause)

	-- init grid 

	self.prefab = gui.get_node(template .. "/" .. "battle_round_card/root")

	print("prefab size is : "  .. gui.get_size(self.prefab))
	
	self.scroll = self.druid:new_scroll("grid_view","grid_content")
	self.scroll:set_vertical_scroll(false)

	self.grid = self.druid:new_static_grid("grid_content",self.prefab, self.battle_info.round_number)

	for i = 1, self.battle_info.round_number do
		local clone_prefab = gui.clone_tree(self.prefab)
		gui.set_enabled(clone_prefab[template .. "/" .. "battle_round_card/root"], true)
		
		print("creating battle_round_card with : " .. json.encode(self.battle_info.player_battle_sequence[i]))
		
		local battle_round_card = self.druid:new(battle_round_card,"battle_round_card", clone_prefab
		,i
		, self.battle_info.player_battle_sequence[i]
		, self.battle_info.opponent_battle_sequence[i])

		self.grid:add(clone_prefab[template .. "/" .. "battle_round_card/root"])

		
	end
	print("grid size is : " .. self.grid:get_size())

	
	self.scroll:set_size(self.grid:get_size())
	self.scroll:bind_grid(self.grid)

	local table_points = {}
	local prefab_size = gui.get_size(self.prefab)
	local starting_pos = vmath.vector3(prefab_size.x/2, 0, 0)
	print("starting pos is : " .. starting_pos)
	local current_pos = starting_pos
	
	for i = 1,self.battle_info.round_number do
		

		if i == 1 then
			local point_pos = vmath.vector3(prefab_size.x/2, 0, 0)
			table.insert(table_points, point_pos)
		
		else 
			local point_pos = vmath.vector3(prefab_size.x/2 + prefab_size.x * (i-1), 0, 0)
			
			print("current pos with x : " .. point_pos)

			table.insert(table_points, point_pos)
			

		end

		

	end

	print("table points : " .. json.encode(table_points))
	
	self.scroll:set_points(table_points)

	

	self.scroll.on_point_scroll:subscribe(function() print("point selected : " .. self.scroll.selected) end)

	-- for some reasons points order is inversed
	self.scroll:scroll_to_index(self.battle_info.round_number)
	print(" scroll position " .. self.scroll.position)
	
	-- disable scroll drag component
	self.scroll.drag:set_enabled(false)
	
	print(self.scroll.selected)

	msg.post(".", "play_battle_round", {index = 1} )
	
	
end

function Component:on_remove() end

return Component