---@meta

---Resource API documentation
---@class resource
resource = {}

---Docs: https://defold.com/ref/stable/resource/?q=resource.material#resource.material
---
---Constructor-like function with two purposes:
---
---Load the specified resource as part of loading the script
---
---Return a hash to the run-time version of the resource
---
---This function can only be called within go.property function calls.
---@param path string|nil optional resource path string to the resource
---@overload fun(): hash
---@return hash path a path hash to the binary version of the resource
function resource.material(path) end

---Docs: https://defold.com/ref/stable/resource/?q=resource.font#resource.font
---
---Constructor-like function with two purposes:
---
---Load the specified resource as part of loading the script
---
---Return a hash to the run-time version of the resource
---
---This function can only be called within go.property function calls.
---@param path string|nil optional resource path string to the resource
---@overload fun(): hash
---@return hash path a path hash to the binary version of the resource
function resource.font(path) end

---Docs: https://defold.com/ref/stable/resource/?q=resource.texture#resource.texture
---
---Constructor-like function with two purposes:
---
---Load the specified resource as part of loading the script
---
---Return a hash to the run-time version of the resource
---
---This function can only be called within go.property function calls.
---@param path string|nil optional resource path string to the resource
---@overload fun(): hash
---@return hash path a path hash to the binary version of the resource
function resource.texture(path) end

---Docs: https://defold.com/ref/stable/resource/?q=resource.atlas#resource.atlas
---
---Constructor-like function with two purposes:
---
---Load the specified resource as part of loading the script
---
---Return a hash to the run-time version of the resource
---
---This function can only be called within go.property function calls.
---@param path string|nil optional resource path string to the resource
---@overload fun(): hash
---@return hash path a path hash to the binary version of the resource
function resource.atlas(path) end

---Docs: https://defold.com/ref/stable/resource/?q=resource.buffer#resource.buffer
---
---Constructor-like function with two purposes:
---
---Load the specified resource as part of loading the script
---
---Return a hash to the run-time version of the resource
---
---This function can only be called within go.property function calls.
---@param path string|nil optional resource path string to the resource
---@overload fun(): hash
---@return hash path a path hash to the binary version of the resource
function resource.buffer(path) end

---Docs: https://defold.com/ref/stable/resource/?q=resource.tile_source#resource.tile_source
---
---Constructor-like function with two purposes:
---
---Load the specified resource as part of loading the script
---
---Return a hash to the run-time version of the resource
---
---This function can only be called within go.property function calls.
---@param path string|nil optional resource path string to the resource
---@overload fun(): hash
---@return hash path a path hash to the binary version of the resource
function resource.tile_source(path) end

---Docs: https://defold.com/ref/stable/resource/?q=resource.set#resource.set
---
---Sets the resource data for a specific resource
---@param path string|hash The path to the resource
---@param buffer buffer The buffer of precreated data, suitable for the intended resource type
function resource.set(path, buffer) end

---Docs: https://defold.com/ref/stable/resource/?q=resource.load#resource.load
---
---Loads the resource data for a specific resource.
---@param path string The path to the resource
---@return buffer buffer Returns the buffer stored on disc
function resource.load(path) end

---Docs: https://defold.com/ref/stable/resource/?q=resource.create_texture#resource.create_texture
---
---Creates a new texture resource that can be used in the same way as any texture created during build time.
---The path used for creating the texture must be unique, trying to create a resource at a path that is already
---registered will trigger an error. If the intention is to instead modify an existing texture, use the resource.set_texture
---function. Also note that the path to the new texture resource must have a '.texturec' extension,
---meaning "/path/my_texture" is not a valid path but "/path/my_texture.texturec" is.
---If the texture is created without a buffer, the pixel data will be blank.
---@param path string The path to the resource.
---@param table {type:number, width:number, height:number, format:number, max_mipmaps:number, compression_type:number} A table containing info about how to create the texture. Supported entries
---@param buffer buffer optional buffer of precreated pixel data
---@return hash path The path to the resource.
function resource.create_texture(path, table, buffer) end

---Docs: https://defold.com/ref/stable/resource/?q=resource.create_texture_async#resource.create_texture_async
---
---Creates a new texture resource that can be used in the same way as any texture created during build time.
---The path used for creating the texture must be unique, trying to create a resource at a path that is already
---registered will trigger an error. If the intention is to instead modify an existing texture, use the resource.set_texture
---function. Also note that the path to the new texture resource must have a '.texturec' extension,
---meaning "/path/my_texture" is not a valid path but "/path/my_texture.texturec" is.
---If the texture is created without a buffer, the pixel data will be blank.
---The difference between the async version and resource.create_texture is that the texture data will be uploaded
---in a graphics worker thread. The function will return a resource immediately that contains a 1x1 blank texture which can be used
---immediately after the function call. When the new texture has been uploaded, the initial blank texture will be deleted and replaced with the
---new texture. Be careful when using the initial texture handle handle as it will not be valid after the upload has finished.
---@param path string The path to the resource.
---@param table {type:number, width:number, height:number, format:number, max_mipmaps:number, compression_type:number} A table containing info about how to create the texture. Supported entries
---@param buffer buffer optional buffer of precreated pixel data
---@return hash path The path to the resource.
---@return handle request_id The request id for the async request.
function resource.create_texture_async(path, table, buffer) end

---Docs: https://defold.com/ref/stable/resource/?q=resource.release#resource.release
---
---Release a resource.
---This is a potentially dangerous operation, releasing resources currently being used can cause unexpected behaviour.
---@param path hash|string The path to the resource.
function resource.release(path) end

---Docs: https://defold.com/ref/stable/resource/?q=resource.set_texture#resource.set_texture
---
---Sets the pixel data for a specific texture.
---@param path hash|string The path to the resource
---@param table {type:number, width:number, height:number, format:number, x:number, y:number, mipmap:number, compression_type:number} A table containing info about the texture. Supported entries
---@param buffer buffer The buffer of precreated pixel data  To update a cube map texture you need to pass in six times the amount of data via the buffer, since a cube map has six sides!
function resource.set_texture(path, table, buffer) end

---Docs: https://defold.com/ref/stable/resource/?q=resource.get_texture_info#resource.get_texture_info
---
---Gets texture info from a texture resource path or a texture handle
---@param path hash|string|handle The path to the resource or a texture handle
---@return {handle:handle, width:integer, height:integer, depth:integer, mipmaps:integer, type:number} table A table containing info about the texture
function resource.get_texture_info(path) end

---Docs: https://defold.com/ref/stable/resource/?q=resource.get_render_target_info#resource.get_render_target_info
---
---Gets render target info from a render target resource path or a render target handle
---@param path hash|string|handle The path to the resource or a render target handle
---@return {handle:handle, handle:handle, width:integer, height:integer, depth:integer, mipmaps:integer, type:number, buffer_type:number} table A table containing info about the render target
function resource.get_render_target_info(path) end

---Docs: https://defold.com/ref/stable/resource/?q=resource.create_atlas#resource.create_atlas
---
---This function creates a new atlas resource that can be used in the same way as any atlas created during build time.
---The path used for creating the atlas must be unique, trying to create a resource at a path that is already
---registered will trigger an error. If the intention is to instead modify an existing atlas, use the resource.set_atlas
---function. Also note that the path to the new atlas resource must have a '.texturesetc' extension,
---meaning "/path/my_atlas" is not a valid path but "/path/my_atlas.texturesetc" is.
---When creating the atlas, at least one geometry and one animation is required, and an error will be
---raised if these requirements are not met. A reference to the resource will be held by the collection
---that created the resource and will automatically be released when that collection is destroyed.
---Note that releasing a resource essentially means decreasing the reference count of that resource,
---and not necessarily that it will be deleted.
---@param path string The path to the resource.
---@param table {texture:string | hash, animations:table, id:string, width:integer, height:integer, frame_start:integer, frame_end:integer, playback:constant, fps:integer, flip_vertical:boolean, flip_horizontal:boolean, geometries:table, id:string, vertices:table, uvs:table, indices:table} A table containing info about how to create the atlas. Supported entries
---@return hash path Returns the atlas resource path
function resource.create_atlas(path, table) end

---Docs: https://defold.com/ref/stable/resource/?q=resource.set_atlas#resource.set_atlas
---
---Sets the data for a specific atlas resource. Setting new atlas data is specified by passing in
---a texture path for the backing texture of the atlas, a list of geometries and a list of animations
---that map to the entries in the geometry list. The geometry entries are represented by three lists:
---vertices, uvs and indices that together represent triangles that are used in other parts of the
---engine to produce render objects from.
---Vertex and uv coordinates for the geometries are expected to be
---in pixel coordinates where 0,0 is the top left corner of the texture.
---There is no automatic padding or margin support when setting custom data,
---which could potentially cause filtering artifacts if used with a material sampler that has linear filtering.
---If that is an issue, you need to calculate padding and margins manually before passing in the geometry data to
---this function.
---@param path hash|string The path to the atlas resource
---@param table {texture:string | hash, animations:table, id:string, width:integer, height:integer, frame_start:integer, frame_end:integer, playback:constant, fps:integer, flip_vertical:boolean, flip_horizontal:boolean, geometries:table, vertices:table, uvs:table, indices:table} A table containing info about the atlas. Supported entries
function resource.set_atlas(path, table) end

---Docs: https://defold.com/ref/stable/resource/?q=resource.get_atlas#resource.get_atlas
---
---Returns the atlas data for an atlas
---@param path hash|string The path to the atlas resource
---@return table data A table with the following entries
function resource.get_atlas(path) end

---Docs: https://defold.com/ref/stable/resource/?q=resource.set_sound#resource.set_sound
---
---Update internal sound resource (wavc/oggc) with new data
---@param path hash|string The path to the resource
---@param buffer string A lua string containing the binary sound data
function resource.set_sound(path, buffer) end

---Docs: https://defold.com/ref/stable/resource/?q=resource.create_buffer#resource.create_buffer
---
---This function creates a new buffer resource that can be used in the same way as any buffer created during build time.
---The function requires a valid buffer created from either buffer.create or another pre-existing buffer resource.
---By default, the new resource will take ownership of the buffer lua reference, meaning the buffer will not automatically be removed
---when the lua reference to the buffer is garbage collected. This behaviour can be overruled by specifying 'transfer_ownership = false'
---in the argument table. If the new buffer resource is created from a buffer object that is created by another resource,
---the buffer object will be copied and the new resource will effectively own a copy of the buffer instead.
---Note that the path to the new resource must have the '.bufferc' extension, "/path/my_buffer" is not a valid path but "/path/my_buffer.bufferc" is.
---The path must also be unique, attempting to create a buffer with the same name as an existing resource will raise an error.
---@param path string The path to the resource.
---@param table {buffer:buffer, transfer_ownership:boolean}|nil A table containing info about how to create the buffer. Supported entries
---@overload fun(path: string): hash
---@return hash path Returns the buffer resource path
function resource.create_buffer(path, table) end

---Docs: https://defold.com/ref/stable/resource/?q=resource.get_buffer#resource.get_buffer
---
---gets the buffer from a resource
---@param path hash|string The path to the resource
---@return buffer buffer The resource buffer
function resource.get_buffer(path) end

---Docs: https://defold.com/ref/stable/resource/?q=resource.set_buffer#resource.set_buffer
---
---Sets the buffer of a resource. By default, setting the resource buffer will either copy the data from the incoming buffer object
---to the buffer stored in the destination resource, or make a new buffer object if the sizes between the source buffer and the destination buffer
---stored in the resource differs. In some cases, e.g performance reasons, it might be beneficial to just set the buffer object on the resource without copying or cloning.
---To achieve this, set the <code>transfer_ownership</code> flag to true in the argument table. Transferring ownership from a lua buffer to a resource with this function
---works exactly the same as resource.create_buffer: the destination resource will take ownership of the buffer held by the lua reference, i.e the buffer will not automatically be removed
---when the lua reference to the buffer is garbage collected.
---Note: When setting a buffer with <code>transfer_ownership = true</code>, the currently bound buffer in the resource will be destroyed.
---@param path hash|string The path to the resource
---@param buffer buffer The resource buffer
---@param table {transfer_ownership:boolean}|nil A table containing info about how to set the buffer. Supported entries
---@overload fun(path: hash|string, buffer: buffer)
function resource.set_buffer(path, buffer, table) end

---Docs: https://defold.com/ref/stable/resource/?q=resource.get_text_metrics#resource.get_text_metrics
---
---Gets the text metrics from a font
---@param url hash the font to get the (unscaled) metrics from
---@param text string text to measure
---@param options {width:integer, leading:number, tracking:number, line_break:boolean}|nil A table containing parameters for the text. Supported entries
---@overload fun(url: hash, text: string): table
---@return table metrics a table with the following fields
function resource.get_text_metrics(url, text, options) end

---2D texture type
resource.TEXTURE_TYPE_2D = nil

---Cube map texture type
resource.TEXTURE_TYPE_CUBE_MAP = nil

---2D Array texture type
resource.TEXTURE_TYPE_2D_ARRAY = nil

---luminance type texture format
resource.TEXTURE_FORMAT_LUMINANCE = nil

---RGB type texture format
resource.TEXTURE_FORMAT_RGB = nil

---RGBA type texture format
resource.TEXTURE_FORMAT_RGBA = nil

---RGB_PVRTC_2BPPV1 type texture format
resource.TEXTURE_FORMAT_RGB_PVRTC_2BPPV1 = nil

---RGB_PVRTC_4BPPV1 type texture format
resource.TEXTURE_FORMAT_RGB_PVRTC_4BPPV1 = nil

---RGBA_PVRTC_2BPPV1 type texture format
resource.TEXTURE_FORMAT_RGBA_PVRTC_2BPPV1 = nil

---RGBA_PVRTC_4BPPV1 type texture format
resource.TEXTURE_FORMAT_RGBA_PVRTC_4BPPV1 = nil

---RGB_ETC1 type texture format
resource.TEXTURE_FORMAT_RGB_ETC1 = nil

---RGBA_ETC2 type texture format
resource.TEXTURE_FORMAT_RGBA_ETC2 = nil

---RGBA_ASTC_4x4 type texture format
resource.TEXTURE_FORMAT_RGBA_ASTC_4x4 = nil

---RGB_BC1 type texture format
resource.TEXTURE_FORMAT_RGB_BC1 = nil

---RGBA_BC3 type texture format
resource.TEXTURE_FORMAT_RGBA_BC3 = nil

---R_BC4 type texture format
resource.TEXTURE_FORMAT_R_BC4 = nil

---RG_BC5 type texture format
resource.TEXTURE_FORMAT_RG_BC5 = nil

---RGBA_BC7 type texture format
resource.TEXTURE_FORMAT_RGBA_BC7 = nil

---RGB16F type texture format
resource.TEXTURE_FORMAT_RGB16F = nil

---RGB32F type texture format
resource.TEXTURE_FORMAT_RGB32F = nil

---RGBA16F type texture format
resource.TEXTURE_FORMAT_RGBA16F = nil

---RGBA32F type texture format
resource.TEXTURE_FORMAT_RGBA32F = nil

---R16F type texture format
resource.TEXTURE_FORMAT_R16F = nil

---RG16F type texture format
resource.TEXTURE_FORMAT_RG16F = nil

---R32F type texture format
resource.TEXTURE_FORMAT_R32F = nil

---RG32F type texture format
resource.TEXTURE_FORMAT_RG32F = nil

---COMPRESSION_TYPE_DEFAULT compression type
resource.COMPRESSION_TYPE_DEFAULT = nil

---BASIS_UASTC compression type
resource.COMPRESSION_TYPE_BASIS_UASTC = nil

