local M = {}


function deepCompare(t1, t2)
	-- Check if both arguments are tables
	if type(t1) ~= "table" or type(t2) ~= "table" then
		return false
	end

	-- Check if tables have the same number of keys
	local t1Keys = {}
	local t2Keys = {}

	for k in pairs(t1) do
		table.insert(t1Keys, k)
	end
	for k in pairs(t2) do
		table.insert(t2Keys, k)
	end

	if #t1Keys ~= #t2Keys then
		return false
	end

	-- Check if tables have the same keys and values
	for k, v in pairs(t1) do
		if type(v) == "table" then
			if not deepCompare(v, t2[k]) then
				return false
			end
		else
			if v ~= t2[k] then
				return false
			end
		end
	end

	return true
end




return M