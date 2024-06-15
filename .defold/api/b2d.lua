---@meta

---Box2D documentation
---@class b2d
b2d = {}

---Docs: https://defold.com/ref/stable/b2d/?q=b2d.get_world#b2d.get_world
---
---Get the Box2D world from the current collection
---@return b2World world the world if successful. Otherwise <code>nil</code>.
function b2d.get_world() end

---Docs: https://defold.com/ref/stable/b2d/?q=b2d.get_body#b2d.get_body
---
---Get the Box2D body from a collision object
---@param url string|hash|url the url to the game object collision component
---@return b2Body body the body if successful. Otherwise <code>nil</code>.
function b2d.get_body(url) end

