local component = require("druid.component")
local monarch = require "monarch.monarch"
local rich_text = require("druid.custom.rich_text.rich_text")
---@class component_name : druid.battle_round_card
local Component = component.create("battle_round_card")

local SCHEME = {
	ROOT = "root",
	RICH_TEXT_PLAYER_ROUND_INFO = "rich_text_player_round_info",
	TEXT_OPPONENT_ROUND_INFO = "text_opponent_round_info", 
	TEXT_PLAYER_ATTACK_NAME = "text_player_attack_name",
	TEXT_PLAYER_RIPOSTE_NAME = "text_player_riposte_name",
	TEXT_OPPONENT_ATTACK_NAME = "text_opponent_attack_name",
	TEXT_OPPONENT_RIPOSTE_NAME = "text_opponent_riposte_name",
}


function Component:init(template, nodes,round_index, player_round_info, opponent_round_info)
	self:set_template(template)
	self:set_nodes(nodes)
	self.root = self:get_node(SCHEME.ROOT)
	self.druid = self:get_druid()

	print("battle card template is : " .. template )
	--local prefab_root_id = "archmon_combat_console/" .. template .. "/" .. "rich_text_battle_round_info/root"
	--self.text_player_round_info = self.druid:new_text(SCHEME.TEXT_PLAYER_ROUND_INFO,"PLAYER ROUND INFO")
	--self.rich_text_prefab = gui.get_node("archmon_combat_console/" .. template .. "/" .. "rich_text_battle_round_info/root")

	self.text_round = self.druid:new_text("text_round",round_index)

	self.text_player_attack_name = self.druid:new_text(SCHEME.TEXT_PLAYER_ATTACK_NAME,"BASIC ATTACK")
	self.text_player_riposte_name = self.druid:new_text(SCHEME.TEXT_PLAYER_RIPOSTE_NAME,"DEFENSE")
	
	self.text_opponent_attack_name = self.druid:new_text(SCHEME.TEXT_OPPONENT_ATTACK_NAME,"BASIC ATTACK")
	self.text_opponent_riposte_name = self.druid:new_text(SCHEME.TEXT_OPPONENT_RIPOSTE_NAME,"DEFENSE")

	
	
	-- player attack sub-card
	local player_action_power = opponent_round_info.target_cypheran.power
	local player_action_roll = player_round_info.player_roll_number
	local dice_player_action_value = nodes["archmon_combat_console/" .. template .. "/" .. "dice_player_action_value"]
	local icon_player_action_power = nodes["archmon_combat_console/" .. template .. "/" .. "value_player_action_power"]
	--self.value_player_action_power = self.druid:new_text("value_player_action_power",player_action_power)
	gui.play_flipbook(icon_player_action_power, "number_" .. player_action_power)
	
	gui.play_flipbook(dice_player_action_value, "number_" .. player_action_roll)
	
--	self.text_opponent_round_info = self.druid:new_text(SCHEME.TEXT_OPPONENT_ROUND_INFO,"PLAYER ROUND INFO")

-- opponent defense sub-card

local opponent_defense_power = player_round_info.target_cypheran.defense
local opponent_defense_roll = player_round_info.target_roll_number
local dice_opponent_defense_value = nodes["archmon_combat_console/" .. template .. "/" .. "dice_opponent_defense_value"]
self.value_opponent_defense_power = self.druid:new_text("value_opponent_defense_power",opponent_defense_power)
gui.play_flipbook(dice_opponent_defense_value, "number_" .. opponent_defense_roll)

-- player result 
local icon_player_result_node = nodes["archmon_combat_console/" .. template .. "/" .. "icon_player_result"]
if player_action_power + player_action_roll > opponent_defense_power + opponent_defense_roll then

	local damage = player_action_power + player_action_roll - (opponent_defense_power + opponent_defense_roll)

	
	self.text_player_result = self.druid:new_text("text_player_result",damage)

else

	self.text_player_result = self.druid:new_text("text_player_result",0)
 --	gui.play_flipbook(icon_player_result_node, "shieldIcon")

end


-- opponent attack sub-card
local opponent_action_power = player_round_info.target_cypheran.power
local opponent_action_roll = opponent_round_info.player_roll_number
local dice_opponent_action_value = nodes["archmon_combat_console/" .. template .. "/" .. "dice_opponent_action_value"]
-- self.value_opponent_action_power = self.druid:new_text("value_opponent_action_power",opponent_action_power)
local icon_opponent_action_power = nodes["archmon_combat_console/" .. template .. "/" .. "value_opponent_action_power"]
--self.value_player_action_power = self.druid:new_text("value_player_action_power",player_action_power)
gui.play_flipbook(icon_opponent_action_power, "number_" .. opponent_action_power)
gui.play_flipbook(dice_opponent_action_value, "number_" .. opponent_action_roll)


-- player defense sub-card

local player_defense_power = opponent_round_info.target_cypheran.defense
local player_defense_roll = opponent_round_info.target_roll_number
local dice_player_defense_value = nodes["archmon_combat_console/" .. template .. "/" .. "dice_player_defense_value"]
self.value_player_defense_power = self.druid:new_text("value_player_defense_power",player_defense_power)
gui.play_flipbook(dice_player_defense_value, "number_" .. player_defense_roll)


-- opponent result 
local icon_opponent_result_node = nodes["archmon_combat_console/" .. template .. "/" .. "icon_opponent_result"]
if opponent_action_power + opponent_action_roll > player_defense_power + player_defense_roll then

	local damage = opponent_action_power + opponent_action_roll - (player_defense_power + player_defense_roll)
	
	
	self.text_opponent_result = self.druid:new_text("text_opponent_result",damage)

else
	self.text_opponent_result = self.druid:new_text("text_opponent_result",0)
	

end

end

function Component:on_remove() end

return Component