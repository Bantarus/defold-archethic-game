-- archethic client manager
local local_storage = require("modules.storage.local_storage")
local M = {}
local endpoint = "https://testnet.archethic.net"

local tx_counter = 0



local smart_contract_address = "00002AA98CD6C56B5142B9406FE2139B2EF4433FE98649423B09C6F094501DFEB3B6"

M.api_functions = {
	ADD_PLAYER = "add_player",
	ATTACK = "attack",
	FEED = "feed",
	HEAL = "heal",
	REFRESH_ACTION_POINTS = "refresh_action_points",
	RESURRECT = "resurrect",
	GET_PLAYER_INFO = "get_player_info",
	GET_ARCHMON_INFO = "get_archmon_info",
	GET_LAST_ACTION = "get_last_action",
	GET_TURN = "get_turn",
	GET_ROUND = "get_round",
	GET_DAY = "get_day",
	GET_MODE = "get_mode",
	GET_PLAYERS = "get_players"
	
}

M.transaction_types = {

	transfer = "transfer",
	
}


function M.generate_encryption_data(password)

	return json.decode(html5.run([[
	console.log("Crypto-js log : ")
	const seed = Crypto.randomSecretKey();
	const publicAddress = Crypto.deriveAddress(seed,0)
	const salt_hex = Utils.uint8ArrayToHex(Crypto.randomSecretKey());
	const password_hex = Utils.uint8ArrayToHex(Utils.maybeStringToUint8Array(`]] .. password .. [[`));
	console.log("password is in encrypt : " + password_hex )
	const combined_hex = salt_hex + password_hex
	
	const aesKey = Crypto.randomSecretKey();
	
	const { publicKey } = Crypto.deriveKeyPair(combined_hex, 0)
	
	console.log("publicKey : " + publicKey);

	console.log("seed : " + seed);
	
	const encryptedAesKey = Crypto.ecEncrypt(aesKey, publicKey);
	const encryptedSeed = Crypto.aesEncrypt(seed, aesKey);
	
	JSON.stringify({ 
	public_address: Utils.uint8ArrayToHex(publicAddress),
	encrypted_seed: Utils.maybeUint8ArrayToHex(encryptedSeed),
	encrypted_aes_key: Utils.maybeUint8ArrayToHex(encryptedAesKey),
	authorized_public_key: Utils.maybeUint8ArrayToHex(publicKey),
	salt: salt_hex
			})]]))
end



function M.verify_secret(secret )
	local encryption_data = local_storage.get_encryption_data()
	local authorized_public_key = encryption_data.authorized_public_key
	local salt = encryption_data.salt
	return json.decode(html5.run([[
	const secret_hex = Utils.uint8ArrayToHex(Utils.maybeStringToUint8Array(`]] .. secret .. [[`))
	const { publicKey } =  Crypto.deriveKeyPair(`]] .. salt .. [[` + secret_hex, 0 );
	JSON.stringify("]] .. authorized_public_key .. [["  == Utils.uint8ArrayToHex(publicKey))

]]))
	
	

end

local function value_to_string(v)
	if type(v) == "string" then
		return '"' .. v .. '"'
	elseif type(v) == "number" or type(v) == "boolean" then
		return tostring(v)
	else
		return '"' .. tostring(v) .. '"'
	end
end

local function list_to_string(string_list)

	local result = {}
	for _, v in ipairs(string_list) do
		table.insert(result, value_to_string(v))
	end
	return "[" .. table.concat(result, ", ") .. "]"

	
	

end

function M.send_transfer_transaction(recipient_action, args )
	local encryption_data = local_storage.get_encryption_data()
	local args_string = "[]"
	
	if args ~= nil and table.getn(args) > 0 then

		args_string = list_to_string(args)

	end
	print("args string : " .. args_string)
	print(" encryption data : " .. json.encode(encryption_data))
	
	local tx = [[
	
	const password_hex = Utils.uint8ArrayToHex(Utils.maybeStringToUint8Array(sessionStorage.getItem("password")));
	console.log("password is : " + password_hex )
	const salt_hex = "]] ..encryption_data.salt .. [[";
	const combined_hex = salt_hex + password_hex
	const {privateKey, publicKey} = Crypto.deriveKeyPair(combined_hex, 0)
	console.log("public key : " + Utils.uint8ArrayToHex(publicKey) )
	const decryptedAesKey = Crypto.ecDecrypt("]] .. encryption_data.encrypted_aes_key .. [[",privateKey)
	const decryptedSeed = Crypto.aesDecrypt("]] .. encryption_data.encrypted_seed .. [[", decryptedAesKey)
	const originPrivateKey = Utils.originPrivateKey
	
	const index = archethic.transaction.getTransactionIndex("]] .. encryption_data.public_address .. [[")
	.then( (index) => {
		console.log("index : " + index )

		const tx = archethic.transaction.new()
			.setType("transfer")
			.addRecipient("]] .. smart_contract_address .. [["
			, "]] .. recipient_action .. [["
			, ]] .. args_string .. [[)
			.build(decryptedSeed, index)
			.originSign(originPrivateKey)
			.on("confirmation",(nbConf, maxConf) => { 
				console.log(nbConf, maxConf)
				JsToDef.send("]] .. recipient_action .. [[_confirmed");
			})
			.on("error",(context, reason ) => {
					console.log("Context: ", context)
					console.log("Reason: " , reason)

					JsToDef.send("]] .. recipient_action .. [[_error", context + " : " + reason );
					
				})

				console.log(tx.toJSON())

			try {

				tx.send()

			} catch (error) {
				console.log(error)
			}
			
		})

		
	
	]]

	return html5.run(tx)

end



function M.build_network_call_function(api_function, args )

	local args_string = "[]"
	print("args : " .. json.encode(args))
	if args ~= nil and table.getn(args) > 0 then

		args_string = list_to_string(args)

	end
	
	print("args string : " .. args_string)
	local request = [[
	try {
		
	archethic.network.callFunction("]] .. smart_contract_address .. [[","]] .. api_function .. [["
	,]] .. args_string .. [[)
	.then( (response) => {
		console.log("archethic.network.callFunction")
		
		sessionStorage.setItem("]] .. api_function .. [[",JSON.stringify(response)) 
	
	})

}catch(error) {
	console.log("error in call function : " + error)
}
]]

	html5.run(request)

end

function M.confirm_sc_call_spent(tx_id)
end


return M



