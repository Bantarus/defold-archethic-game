local game_archethic = require("modules.networking.game_archethic")
local utils = require("modules.common.utils")
local M = {}

M.item_keys = {

	GET_PLAYER_INFO = "get_player_info",
	GET_PLAYERS = "get_players"


}

function M.set_item(key,string_value)

	html5.run(string.format([[
	sessionStorage.setItem("%s","%s");

	]], key,string_value))

	return true

end

function M.get_item(key)

	local value = html5.run(string.format([[
	sessionStorage.getItem("%s");
	]], key))

	return value

end

function M.remove_item(key)


	local value = html5.run(string.format([[
	sessionStorage.removeItem("%s");
	]], key))

	return true

end


function M.clear()


	html5.run(string.format([[
	sessionStorage.clear();
	]], key))

	return true
end

local function force_update(self, api_key, current_value)

	print("hello from force update coroutine")


	local session_decoded_value = {}

	while true do

		local session_decoded_value = json.decode(M.get_item(game_archethic.api_functions[api_key]))

		if session_decoded_value ~= nil and session_decoded_value ~= current_value then 

			coroutine.yield(session_decoded_value) 

		end


	end

end

function M.check_update(self, api_key, current_value , callback, force)

	local session_decoded_value = {}

	if force then
		local co = coroutine.create(force_update)
		local success, value = coroutine.resume(co,self,api_key,current_value)

		if success then

			session_decoded_value = value
		end


		


	else 

		session_decoded_value = json.decode(M.get_item(game_archethic.api_functions[api_key]))


	end

	--print("session_decoded_value : " .. json.encode(session_decoded_value))
	--print("current_value : " .. json.encode(current_value)  ) 

	if session_decoded_value ~= nil and not utils.deepCompare(session_decoded_value,current_value) then

		
		callback(session_decoded_value)
		

		end
		

end



return M