local M = {}


function M.wait(seconds)
	local start = os.time()
	repeat until os.time() > start + seconds
end

function M.compareKeyEquality(t1, t2, key)
	-- Check if both arguments are tables and if the key exists in both tables
	if type(t1) ~= "table" or type(t2) ~= "table" then
		return false
	end

	-- Check if the key exists in both tables
	if t1[key] == nil or t2[key] == nil then
		return false
	end

	-- Compare the values of the key in both tables
	return t1[key] == t2[key]
end

function M.deepCompare(t1, t2)
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
			if not M.deepCompare(v, t2[k]) then
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