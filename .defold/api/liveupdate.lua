---@meta

---LiveUpdate API documentation
---@class liveupdate
liveupdate = {}

---Docs: https://defold.com/ref/stable/liveupdate/?q=liveupdate.get_current_manifest#liveupdate.get_current_manifest
---
---Return a reference to the Manifest that is currently loaded.
---@return number manifest_reference reference to the Manifest that is currently loaded
function liveupdate.get_current_manifest() end

---Docs: https://defold.com/ref/stable/liveupdate/?q=liveupdate.store_resource#liveupdate.store_resource
---
---add a resource to the data archive and runtime index. The resource will be verified
---internally before being added to the data archive.
---@param manifest_reference number The manifest to check against.
---@param data string The resource data that should be stored.
---@param hexdigest string The expected hash for the resource, retrieved through collectionproxy.missing_resources.
---@param callback fun(self:object, hexdigest:string, status:boolean) The callback
function liveupdate.store_resource(manifest_reference, data, hexdigest, callback) end

---Docs: https://defold.com/ref/stable/liveupdate/?q=liveupdate.store_manifest#liveupdate.store_manifest
---
---Create a new manifest from a buffer. The created manifest is verified
---by ensuring that the manifest was signed using the bundled public/private
---key-pair during the bundle process and that the manifest supports the current
---running engine version. Once the manifest is verified it is stored on device.
---The next time the engine starts (or is rebooted) it will look for the stored
---manifest before loading resources. Storing a new manifest allows the
---developer to update the game, modify existing resources, or add new
---resources to the game through LiveUpdate.
---@param manifest_buffer string the binary data that represents the manifest
---@param callback fun(self:object, status:constant) the callback function
function liveupdate.store_manifest(manifest_buffer, callback) end

---Docs: https://defold.com/ref/stable/liveupdate/?q=liveupdate.store_archive#liveupdate.store_archive
---
---Stores a zip file and uses it for live update content. The contents of the
---zip file will be verified against the manifest to ensure file integrity.
---It is possible to opt out of the resource verification using an option passed
---to this function.
---The path is stored in the (internal) live update location.
---@param path string the path to the original file on disc
---@param callback fun(self:object, status:constant) the callback function
---@param options {verify:boolean}|nil optional table with extra parameters. Supported entries
---@overload fun(path: string, callback: fun(self:object, status:constant))
function liveupdate.store_archive(path, callback, options) end

---Docs: https://defold.com/ref/stable/liveupdate/?q=liveupdate.is_using_liveupdate_data#liveupdate.is_using_liveupdate_data
---
---Is any liveupdate data mounted and currently in use?
---This can be used to determine if a new manifest or zip file should be downloaded.
---@return bool bool true if a liveupdate archive (any format) has been loaded
function liveupdate.is_using_liveupdate_data() end

---Docs: https://defold.com/ref/stable/liveupdate/?q=liveupdate.get_mounts#liveupdate.get_mounts
---
---Get an array of the current mounts
---This can be used to determine if a new mount is needed or not
---@return array mounts Array of mounts
function liveupdate.get_mounts() end

---Docs: https://defold.com/ref/stable/liveupdate/?q=liveupdate.add_mount#liveupdate.add_mount
---
---Adds a resource mount to the resource system.
---The mounts are persisted between sessions.
---After the mount succeeded, the resources are available to load. (i.e. no reboot required)
---@param name string Unique name of the mount
---@param uri string The uri of the mount, including the scheme. Currently supported schemes are 'zip' and 'archive'.
---@param priority integer Priority of mount. Larger priority takes prescedence
---@param callback function Callback after the asynchronous request completed
---@return number result The result of the request
function liveupdate.add_mount(name, uri, priority, callback) end

---Docs: https://defold.com/ref/stable/liveupdate/?q=liveupdate.remove_mount#liveupdate.remove_mount
---
---Remove a mount the resource system.
---The remaining mounts are persisted between sessions.
---Removing a mount does not affect any loaded resources.
---@param name string Unique name of the mount
---@return number result The result of the call
function liveupdate.remove_mount(name) end

---LIVEUPDATE_OK
liveupdate.LIVEUPDATE_OK = nil

---The handled resource is invalid.
liveupdate.LIVEUPDATE_INVALID_HEADER = nil

---Memory wasn't allocated
liveupdate.LIVEUPDATE_MEM_ERROR = nil

---The header of the resource is invalid.
liveupdate.LIVEUPDATE_INVALID_RESOURCE = nil

---Mismatch between manifest expected version and actual version.
liveupdate.LIVEUPDATE_VERSION_MISMATCH = nil

---Mismatch between running engine version and engine versions supported by manifest.
liveupdate.LIVEUPDATE_ENGINE_VERSION_MISMATCH = nil

---Mismatch between manifest expected signature and actual signature.
liveupdate.LIVEUPDATE_SIGNATURE_MISMATCH = nil

---Mismatch between scheme used to load resources. Resources are loaded with a different scheme than from manifest, for example over HTTP or directly from file. This is typically the case when running the game directly from the editor instead of from a bundle.
liveupdate.LIVEUPDATE_SCHEME_MISMATCH = nil

---Mismatch between between expected bundled resources and actual bundled resources. The manifest expects a resource to be in the bundle, but it was not found in the bundle. This is typically the case when a non-excluded resource was modified between publishing the bundle and publishing the manifest.
liveupdate.LIVEUPDATE_BUNDLED_RESOURCE_MISMATCH = nil

---Failed to parse manifest data buffer. The manifest was probably produced by a different engine version.
liveupdate.LIVEUPDATE_FORMAT_ERROR = nil

---I/O operation failed
liveupdate.LIVEUPDATE_IO_ERROR = nil

---Argument was invalid
liveupdate.LIVEUPDATE_INVAL = nil

---Unspecified error
liveupdate.LIVEUPDATE_UNKNOWN = nil

