---@meta

---Camera API documentation
---@class camera
camera = {}

---
---Post this message to a camera-component to set its properties at run-time.
---
---@class set_camera_msg
---@field aspect_ratio number aspect ratio of the screen (width divided by height)
---@field fov number field of view of the lens, measured as the angle in radians between the right and left edge
---@field near_z number position of the near clipping plane (distance from camera along relative z)
---@field far_z number position of the far clipping plane (distance from camera along relative z)
---@field orthographic_projection bool set to use an orthographic projection
---@field orthographic_zoom number zoom level when the camera is using an orthographic projection

