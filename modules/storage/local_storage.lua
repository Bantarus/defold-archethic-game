local dsave = require("defsave.defsave")

local M = {}

local player_profile = "player_profile"

local item_paths = {
	username = "username",
	public_address = "public_address",
	encryption_data = "encryption_data",
	player_info = "player_info"
	
}

function M.is_player_profile_empty()

	local next = next

	return  next(dsave.loaded[player_profile].data) == nil

end





function M.save_username(username)

	assert(dsave.is_loaded(player_profile), "User profile have to be initialized with init()")

	dsave.set(player_profile, item_paths.username, username)

	dsave.save(player_profile)


end

function M.get_username()

	assert(dsave.is_loaded(player_profile), "User profile have to be initialized with init()")

	return dsave.get(player_profile, item_paths.username)


end

function M.get_player_info()
	
	assert(dsave.is_loaded(player_profile), "User profile have to be initialized with init()")

	return dsave.get(player_profile, item_paths.player_info)
	

end


function M.set_player_info(player_info)
	
	assert(dsave.is_loaded(player_profile), "User profile have to be initialized with init()")

	dsave.set(player_profile, item_paths.player_info, player_info)

	dsave.save(player_profile)
	
end
	


function M.get_public_address()

	assert(dsave.is_loaded(player_profile), "User profile have to be initialized with init()")

	return dsave.get(player_profile, item_paths.encryption_data).public_address


end



function M.save_encryption_data(encryption_data)

	assert(dsave.is_loaded(player_profile), "User profile have to be initialized with init()")

	
	dsave.set(player_profile, item_paths.encryption_data, encryption_data)

	dsave.save(player_profile)
	


end

function M.get_encryption_data()

	assert(dsave.is_loaded(player_profile), "User profile have to be initialized with init()")

	return dsave.get(player_profile, item_paths.encryption_data)
	
end
	

function M.reset()

	dsave.reset_to_default(player_profile)

	dsave.save(player_profile)

	return true

end

function M.init()

	dsave.appname = "battlechain_game"
	dsave.load(player_profile)

end

return M