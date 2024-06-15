---@meta

---Image API documentation
---@class image
image = {}

---Docs: https://defold.com/ref/stable/image/?q=image.load#image.load
---
---Load image (PNG or JPEG) from buffer.
---@param buffer string image data buffer
---@param options {premultiply_alpha:boolean, flip_vertically:boolean}|nil An optional table containing parameters for loading the image. Supported entries
---@overload fun(buffer: string): table|nil
---@return table|nil image object or <code>nil</code> if loading fails. The object is a table with the following fields:  number <code>width</code>: image width  number <code>height</code>: image height  constant <code>type</code>: image type <code>image.TYPE_RGB</code>  <code>image.TYPE_RGBA</code>  <code>image.TYPE_LUMINANCE</code>  <code>image.TYPE_LUMINANCE_ALPHA</code>    string <code>buffer</code>: the raw image data 
function image.load(buffer, options) end

---Docs: https://defold.com/ref/stable/image/?q=image.load_buffer#image.load_buffer
---
---Load image (PNG or JPEG) from a string buffer.
---@param buffer string image data buffer
---@param options {premultiply_alpha:boolean, flip_vertically:boolean}|nil An optional table containing parameters for loading the image. Supported entries
---@overload fun(buffer: string): table|nil
---@return table|nil image object or <code>nil</code> if loading fails. The object is a table with the following fields:  number <code>width</code>: image width  number <code>height</code>: image height  constant <code>type</code>: image type <code>image.TYPE_RGB</code>  <code>image.TYPE_RGBA</code>  <code>image.TYPE_LUMINANCE</code>  <code>image.TYPE_LUMINANCE_ALPHA</code>    buffer <code>buffer</code>: the script buffer that holds the decompressed image data. See buffer.create how to use the buffer. 
function image.load_buffer(buffer, options) end

---RGB image type
image.TYPE_RGB = nil

---RGBA image type
image.TYPE_RGBA = nil

---luminance image type
image.TYPE_LUMINANCE = nil

---luminance image type
image.TYPE_LUMINANCE_ALPHA = nil

