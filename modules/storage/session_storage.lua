local M = {}

M.item_keys = {

	PLAYER_INFO = "player_info",


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


return M