local component = require("druid.component")
local monarch = require "monarch.monarch"

---@class component_name : druid.navigation_menu
local Component = component.create("navigation_menu")

local SCHEME = {
	ROOT = "root",
	BUTTON_RULES = "button_rules",
	BUTTON_PLAY = "button_play",
	BUTTON_HOUSE = "button_house",

}

local function on_click_rules()

	monarch.show(hash("rules"))


end

local function on_click_play()

	monarch.show(hash("play"))


end

local function on_click_house()

	monarch.show(hash("home"))


end

function Component:init(template, nodes)
	self:set_template(template)
	self:set_nodes(nodes)
	self.root = self:get_node(SCHEME.ROOT)
	self.druid = self:get_druid()

	self.button_rules = self.druid:new_button(SCHEME.BUTTON_RULES, on_click_rules)

	self.button_play = self.druid:new_button(SCHEME.BUTTON_PLAY, on_click_play)

	self.button_house = self.druid:new_button(SCHEME.BUTTON_HOUSE,on_click_house)


end

function Component:on_remove() end

return Component