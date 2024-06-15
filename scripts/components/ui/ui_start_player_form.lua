local component = require("druid.component")
local input = require ("druid.extended.input")
local monarch = require("monarch.monarch")
---@class start_player_form : druid.start_player_form
local Component = component.create("start_player_form")
local local_storage = require("modules.storage.local_storage")
local game_archethic = require("modules.networking.game_archethic")
local session_storage = require("modules.storage.session_storage")

local constants = require("modules.common.constants")

local SCHEME = {
	ROOT = "root",
	BUTTON_BACK = "button_back",
	BUTTON_CONTINUE = "button_continue",
	INPUT_USERNAME = "input_username",
	TEXT_USERNAME = "text_username",
	INPUT_SECRET = "secret",
	TEXT_FORM_INVALID = "text_form_invalid",


}


local function on_click_back()

	local_storage.reset()

	monarch.back()

end

local function on_click_continue(self)

	--check inputs not empty

	if self.input_secret.is_empty or self:get_template() == "register_player_form" and self.input_username.is_empty then

		print("missing inputs")
		msg.post(".", "missing_input")

		gui.set_text(self.text_form_invalid.node, "MISSING INPUT(S)")

		return

	end 


	-- save secret in browser session storage 
	print("session password : " .. self.input_secret:get_text())
	session_storage.set_item("password", self.input_secret:get_text())
	
	-- save player profile if template register 

	if self:get_template() == "register_player_form" then

		



		-- generate wallet seed and aes encrypt it 
		-- and ec encrypt aes key with public key derived from secret 
		-- before saving locally

		

		print("input secret : " .. self.input_secret:get_text())

		local encryption_data = game_archethic.generate_encryption_data(self.input_secret:get_text())


		
		
		print ("encryption data is : " .. json.encode(encryption_data))

		local_storage.save_encryption_data(encryption_data)

		local_storage.save_username(self.input_username:get_text())

		


	else 

		-- verify password 
		local encryption_data = local_storage.get_encryption_data()

		if not game_archethic.verify_secret(self.input_secret:get_text()
		,encryption_data.authorized_public_key, encryption_data.salt)  then


			
			print("wrong password") 

			gui.set_text(self.text_form_invalid.node, "WRONG PASSWORD")

			return
		end

		

	end


	monarch.show(hash("play"))


end

local function on_input_selected( self, button_node )


	print("input selected")

	
	if self:get_text() == self.default_text then

		self:set_text("")

	else 

		self.keyboard_type = gui.KEYBOARD_TYPE_DEFAULT
		local current_text = self:get_text()
		self:set_text("")
		self:set_text(current_text)

	
	end 

	

end


local function on_input_unselected( self, button_node )


	print("input unselected")


	if self.is_empty then
		
		self.keyboard_type = gui.KEYBOARD_TYPE_DEFAULT
		self:set_text(self.default_text)

	elseif self.is_password then 

		self.keyboard_type = gui.KEYBOARD_TYPE_PASSWORD
		local current_text = self:get_text()
		self:set_text("")
		self:set_text(current_text)
		

	end 

	

end


function Component:init(template, nodes)
	self:set_template(template)
	self:set_nodes(nodes)
	self.root = self:get_node(SCHEME.ROOT)
	self.druid = self:get_druid()

	self.button_back = self.druid:new_button(SCHEME.BUTTON_BACK, on_click_back)

	self.button_continue = self.druid:new_button(SCHEME.BUTTON_CONTINUE, on_click_continue)
	
	
	if  template == "register_player_form" then

		
		self.input_username = self.druid:new(input,"box_input_username","text_input_username")
		:set_max_length(20)

		self.input_username.default_text = constants.player_form_texts.input_username_default_text
		self.input_username:set_text(self.input_username.default_text)
		
		self.input_username.on_input_select:subscribe(on_input_selected
		,self.input_username )
		self.input_username.on_input_unselect:subscribe(on_input_unselected
		,self.input_username )
	

	else -- assuming is login

		self.text_username = self.druid:new_text("text_username")
		gui.set_text(self.text_username.node, local_storage.get_username())
		
	end


	self.input_secret = self.druid:new(input,"box_input_secret","text_input_secret")
	:set_max_length(32)
	self.input_secret.on_input_select:subscribe(on_input_selected
	,self.input_secret )

	self.input_secret.on_input_unselect:subscribe(on_input_unselected
	,self.input_secret )

	self.input_secret.default_text = constants.player_form_texts.input_secret_default_text
	-- self.input_secret:set_text(self.input_secret.default_text)
	self.input_secret.is_password = true
	

	self.text_form_invalid = self.druid:new_text("text_form_invalid")

	print("ui player form ready.")

end

function Component:on_remove() end

return Component