-- SHA-1 implementation
local bor = bit.bor
local band = bit.band
local bxor = bit.bxor
local rshift = bit.rshift
local lshift = bit.lshift
local rol = bit.rol

local function to_bytes(n)
	return string.char(
	band(rshift(n, 24), 0xFF),
	band(rshift(n, 16), 0xFF),
	band(rshift(n, 8), 0xFF),
	band(n, 0xFF)
)
end

local function from_bytes(b, i)
local a, b, c, d = string.byte(b, i, i + 3)
return bor(lshift(a, 24), lshift(b, 16), lshift(c, 8), d)
end

local function str2hexa(s)
return (s:gsub('.', function(c)
	return string.format('%02x', string.byte(c))
end))
end

local function str2bin(s)
return (s:gsub('..', function(cc)
	return string.char(tonumber(cc, 16))
end))
end

local function sha1(msg)
local h0, h1, h2, h3, h4 = 0x67452301, 0xEFCDAB89, 0x98BADCFE, 0x10325476, 0xC3D2E1F0
local msg_len_in_bits = #msg * 8

msg = msg .. "\x80" .. string.rep("\0", 63 - (#msg + 8) % 64) .. to_bytes(msg_len_in_bits)

local w = {}
for i = 1, #msg, 64 do
	for j = 0, 15 do
		w[j] = from_bytes(msg, i + j * 4)
	end

	for j = 16, 79 do
		w[j] = rol(bxor(w[j - 3], w[j - 8], w[j - 14], w[j - 16]), 1)
	end

	local a, b, c, d, e = h0, h1, h2, h3, h4

	for j = 0, 79 do
		local f, k
		if j < 20 then
			f = bor(band(b, c), band(bnot(b), d))
			k = 0x5A827999
		elseif j < 40 then
			f = bxor(b, c, d)
			k = 0x6ED9EBA1
		elseif j < 60 then
			f = bor(band(b, c), band(b, d), band(c, d))
			k = 0x8F1BBCDC
		else
			f = bxor(b, c, d)
			k = 0xCA62C1D6
		end

		local temp = rol(a, 5) + f + e + k + w[j]
		e = d
		d = c
		c = rol(b, 30)
		b = a
		a = temp
	end

	h0 = h0 + a
	h1 = h1 + b
	h2 = h2 + c
	h3 = h3 + d
	h4 = h4 + e
end

return str2bin(to_bytes(h0) .. to_bytes(h1) .. to_bytes(h2) .. to_bytes(h3) .. to_bytes(h4))
end

-- HMAC-SHA1 implementation
local function hmac_sha1(key, message)
if #key > 64 then
	key = sha1(key)
end
key = key .. string.rep("\0", 64 - #key)

local o_key_pad = bxor(0x5c5c5c5c, string.byte(key, 1, #key))
local i_key_pad = bxor(0x36363636, string.byte(key, 1, #key))

return sha1(string.char(o_key_pad) .. sha1(string.char(i_key_pad) .. message))
end

-- PBKDF2 implementation
local function pbkdf2_sha1(password, salt, iterations, dk_len)
	local h_len = 20  -- SHA1 produces a 20 byte hash
	local l = math.ceil(dk_len / h_len)
	local r = dk_len - (l - 1) * h_len

	local function xor_str(a, b)
		local res = {}
		for i = 1, #a do
			res[i] = string.char(bxor(string.byte(a, i), string.byte(b, i)))
		end
		return table.concat(res)
	end

	local function int_to_bytes(i)
		return string.char(
		band(rshift(i, 24), 0xFF),
		band(rshift(i, 16), 0xFF),
		band(rshift(i, 8), 0xFF),
		band(i, 0xFF)
	)
end

local function f(password, salt, iterations, i)
	local u = hmac_sha1(password, salt .. int_to_bytes(i))
	local t = u
	for _ = 2, iterations do
		u = hmac_sha1(password, u)
		t = xor_str(t, u)
	end
	return t
end

local dk = {}
for i = 1, l do
	table.insert(dk, f(password, salt, iterations, i))
end
return string.sub(table.concat(dk), 1, dk_len)
end

