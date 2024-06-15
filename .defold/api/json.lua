---@meta

---JSON API documentation
---@class json
json = {}

---Docs: https://defold.com/ref/stable/json/?q=json.decode#json.decode
---
---Decode a string of JSON data into a Lua table.
---A Lua error is raised for syntax errors.
---@param json string json data
---@param options {decode_null_as_userdata:bool}|nil table with decode options
---@overload fun(json: string): table
---@return table data decoded json
function json.decode(json, options) end

---Docs: https://defold.com/ref/stable/json/?q=json.encode#json.encode
---
---Encode a lua table to a JSON string.
---A Lua error is raised for syntax errors.
---@param tbl table lua table to encode
---@param options {encode_empty_table_as_object:string}|nil table with encode options
---@overload fun(tbl: table): string
---@return string json encoded json
function json.encode(tbl, options) end

---Represents the null primitive from a json file
json.null = nil

