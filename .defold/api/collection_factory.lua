---@meta

---Collection factory API documentation
---@class collectionfactory
collectionfactory = {}

---Docs: https://defold.com/ref/stable/collectionfactory/?q=collectionfactory.get_status#collectionfactory.get_status
---
---This returns status of the collection factory.
---Calling this function when the factory is not marked as dynamic loading always returns COMP_COLLECTION_FACTORY_STATUS_LOADED.
---@param url string|hash|url|nil the collection factory component to get status from
---@overload fun(): constant
---@return constant status status of the collection factory component  <code>collectionfactory.STATUS_UNLOADED</code>  <code>collectionfactory.STATUS_LOADING</code>  <code>collectionfactory.STATUS_LOADED</code> 
function collectionfactory.get_status(url) end

---Docs: https://defold.com/ref/stable/collectionfactory/?q=collectionfactory.unload#collectionfactory.unload
---
---This decreases the reference count for each resource loaded with collectionfactory.load. If reference is zero, the resource is destroyed.
---Calling this function when the factory is not marked as dynamic loading does nothing.
---@param url string|hash|url|nil the collection factory component to unload
---@overload fun()
function collectionfactory.unload(url) end

---Docs: https://defold.com/ref/stable/collectionfactory/?q=collectionfactory.load#collectionfactory.load
---
---Resources loaded are referenced by the collection factory component until the existing (parent) collection is destroyed or collectionfactory.unload is called.
---Calling this function when the factory is not marked as dynamic loading does nothing.
---@param url string|hash|url|nil the collection factory component to load
---@param complete_function fun(self:object, url:url, result:boolean)|nil function to call when resources are loaded.
---@overload fun()
---@overload fun(url: string|hash|url|nil)
function collectionfactory.load(url, complete_function) end

---Docs: https://defold.com/ref/stable/collectionfactory/?q=collectionfactory.create#collectionfactory.create
---
---The URL identifies the collectionfactory component that should do the spawning.
---Spawning is instant, but spawned game objects get their first update calls the following frame. The supplied parameters for position, rotation and scale
---will be applied to the whole collection when spawned.
---Script properties in the created game objects can be overridden through
---a properties-parameter table. The table should contain game object ids
---(hash) as keys and property tables as values to be used when initiating each
---spawned game object.
---See go.property for more information on script properties.
---The function returns a table that contains a key for each game object
---id (hash), as addressed if the collection file was top level, and the
---corresponding spawned instance id (hash) as value with a unique path
---prefix added to each instance.
---Calling collectionfactory.create create on a collection factory that is marked as dynamic without having loaded resources
---using collectionfactory.load will synchronously load and create resources which may affect application performance.
---@param url string|hash|url the collection factory component to be used
---@param position vector3|nil position to assign to the newly spawned collection
---@param rotation quaternion|nil rotation to assign to the newly spawned collection
---@param properties table|nil table of script properties to propagate to any new game object instances
---@param scale number|nil uniform scaling to apply to the newly spawned collection (must be greater than 0).
---@overload fun(url: string|hash|url): table
---@overload fun(url: string|hash|url, position: vector3|nil): table
---@overload fun(url: string|hash|url, position: vector3|nil, rotation: quaternion|nil): table
---@overload fun(url: string|hash|url, position: vector3|nil, rotation: quaternion|nil, properties: table|nil): table
---@return table ids a table mapping the id:s from the collection to the new instance id:s
function collectionfactory.create(url, position, rotation, properties, scale) end

---Docs: https://defold.com/ref/stable/collectionfactory/?q=collectionfactory.set_prototype#collectionfactory.set_prototype
---
---Changes the prototype for the collection factory.
---Setting the prototype to "nil" will revert back to the original prototype.
---@param url string|hash|url|nil the collection factory component
---@param prototype string|nil the path to the new prototype, or <code>nil</code>
---@overload fun()
---@overload fun(url: string|hash|url|nil)
function collectionfactory.set_prototype(url, prototype) end

---unloaded
collectionfactory.STATUS_UNLOADED = nil

---loading
collectionfactory.STATUS_LOADING = nil

---loaded
collectionfactory.STATUS_LOADED = nil

