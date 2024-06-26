local component = require("druid.component")
local progress = require ("druid.extended.progress")
local monarch = require "monarch.monarch"
local local_storage = require("modules.storage.local_storage")
local session_storage = require("modules.storage.session_storage")
local utils = require("modules.common.utils")

---@class component_name : druid.archmon_card
local Component = component.create("archmon_card")

local SCHEME = {
	ROOT = "root",
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
local function update_card(self,archmon)


	print("display archmon card update : "  .. json.encode(archmon))

	local health_pct_value = math.floor(archmon.health / archmon.base_health * 100 ) / 100

	self.health_bar:to(health_pct_value)
	local text_health = archmon.health .. "/" .. archmon.base_health
	gui.set_text(self.text_health.node,text_health )


	gui.set_text(self.text_power.node, archmon.power)
	gui.set_text(self.text_defense.node, archmon.defense)

	local xp_pct_value = math.floor(archmon.xp / (archmon.level * 20 ) * 100 ) / 100
	self.xp_bar:to(xp_pct_value)  

	local text_xp = archmon.xp .. "/" .. (archmon.level * 20 )
	gui.set_text(self.text_xp.node, text_xp)

	local text_level = "L." .. archmon.level

	gui.set_text(self.text_level.node, text_level)

	-- energy grid filling

	local energy_filler_up_to = archmon.energy
	for i = 1, 5 do

		if i <= energy_filler_up_to then
			gui.set_enabled(self.energy_grid_slots[i][self:get_template() .. "/energy_slot_fill"],true)

		else
			gui.set_enabled(self.energy_grid_slots[i][self:get_template() .. "/energy_slot_fill"],false)
		end
	end

end





local function add_energy_node(self, index)
	local cloned = gui.clone_tree(self.energy_prefab)
	gui.set_enabled(cloned[self:get_template() .. "/energy_slot_prefab"], true)
	self.energy_grid:add(cloned[self:get_template() .. "/energy_slot_prefab"], index)
	table.insert(self.energy_grid_slots,cloned)
end





function Component:init(template, nodes, archmon, parent)
	self:set_template(template)
	self:set_nodes(nodes)
	self.root = self:get_node(SCHEME.ROOT)
	self.druid = self:get_druid()

	self.archmon = archmon

	self.text_archmon_name = self.druid:new_text(nodes[self:get_template() .. "/text_archmon_name"],"ARCHMON")


	self.text_level = self.druid:new_text(nodes[self:get_template() .. "/text_level"],"L." .. archmon.level)


	self.health_bar = self.druid:new(progress,nodes[self:get_template() .. "/health_fill_x"],"x", archmon.health / archmon.base_health)
	self.text_health = self.druid:new_text(nodes[self:get_template() .. "/text_health"], archmon.health .. "/" .. archmon.base_health)
	self.health_bar.on_change:subscribe(function(_, value)

		gui.set_text(self.text_health.node, self.archmon.health .. "/" .. self.archmon.base_health)

	end)

	self.text_power =  self.druid:new_text(nodes[self:get_template() .. "/text_power"],archmon.power)
	self.text_defense =  self.druid:new_text(nodes[self:get_template() .. "/text_defense"],archmon.defense)
	
	self.xp_bar = self.druid:new(progress,nodes[self:get_template() .. "/xp_fill_x"],"x", archmon.xp / (archmon.level * 20 ))
	self.xp_bar.on_change:subscribe(function(_, value)


		gui.set_text(self.text_xp.node, self.archmon.xp .. "/" .. self.archmon.xp_to_next_level)
	end)

	self.text_xp = self.druid:new_text(nodes[self:get_template() .. "/text_xp"],archmon.xp .. "/" .. (archmon.level * 20 ))


	-- energy bar as static grid

	self.energy_grid = self.druid:new_static_grid(self:get_node("energy_grid_content"), self:get_node("energy_slot_prefab"), 5)
	:set_position_function(simple_animate)

	self.energy_prefab = self:get_node("energy_slot_prefab")
	gui.set_enabled(self.energy_prefab, false)
	self.energy_grid_slots = {}
	for i = 1, 5 do
		add_energy_node(self, i)
	end

		-- energy grid filling

		local energy_filler_up_to = archmon.energy

		for i = 1, 5 do

			if i <= energy_filler_up_to then
				gui.set_enabled(self.energy_grid_slots[i][self:get_template() .. "/energy_slot_prefab"],true)

			else
				gui.set_enabled(self.energy_grid_slots[i][self:get_template() .. "/energy_slot_prefab"],false)
			end
		end

end

function Component:update_health(archmon) 

	print("update health : " .. json.encode(archmon))
	self.archmon = archmon
	local health_pct_value = math.floor(archmon.health / archmon.base_health * 100 ) / 100

	self.health_bar:to(health_pct_value)
	--local text_health = archmon.health .. "/" .. archmon.base_health
	--print(text_health)
	--gui.set_text(self.text_health.node,text_health )
	

end

	
function Component:on_remove() end



function Component:on_message(message_id, message, sender) 



end

return Component