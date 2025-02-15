---@meta

---Tilemap API documentation
---@class tilemap
tilemap = {}

---Docs: https://defold.com/ref/stable/tilemap/?q=tilemap.set_tile#tilemap.set_tile
---
---Replace a tile in a tile map with a new tile.
---The coordinates of the tiles are indexed so that the "first" tile just
---above and to the right of origin has coordinates 1,1.
---Tiles to the left of and below origin are indexed 0, -1, -2 and so forth.
---
---+-------+-------+------+------+
---|  0,3  |  1,3  | 2,3  | 3,3  |
---+-------+-------+------+------+
---|  0,2  |  1,2  | 2,2  | 3,2  |
---+-------+-------+------+------+
---|  0,1  |  1,1  | 2,1  | 3,1  |
---+-------O-------+------+------+
---|  0,0  |  1,0  | 2,0  | 3,0  |
---+-------+-------+------+------+
---
---
---The coordinates must be within the bounds of the tile map as it were created.
---That is, it is not possible to extend the size of a tile map by setting tiles outside the edges.
---To clear a tile, set the tile to number 0. Which tile map and layer to manipulate is identified by the URL and the layer name parameters.
---Transform bitmask is arithmetic sum of one or both FLIP constants (<code>tilemap.H_FLIP</code>, <code>tilemap.V_FLIP</code>) and/or one of ROTATION constants
---(<code>tilemap.ROTATE_90</code>, <code>tilemap.ROTATE_180</code>, <code>tilemap.ROTATE_270</code>).
---Flip always applies before rotation (clockwise).
---@param url string|hash|url the tile map
---@param layer string|hash name of the layer for the tile
---@param x number x-coordinate of the tile
---@param y number y-coordinate of the tile
---@param tile number index of new tile to set. 0 resets the cell
---@param transform-bitmask number|nil optional flip and/or rotation should be applied to the tile
---@overload fun(url: string|hash|url, layer: string|hash, x: number, y: number, tile: number)
function tilemap.set_tile(url, layer, x, y, tile, transform-bitmask) end

---Docs: https://defold.com/ref/stable/tilemap/?q=tilemap.get_tile#tilemap.get_tile
---
---Get the tile set at the specified position in the tilemap.
---The position is identified by the tile index starting at origin
---with index 1, 1. (see tilemap.set_tile())
---Which tile map and layer to query is identified by the URL and the
---layer name parameters.
---@param url string|hash|url the tile map
---@param layer string|hash name of the layer for the tile
---@param x number x-coordinate of the tile
---@param y number y-coordinate of the tile
---@return number tile index of the tile
function tilemap.get_tile(url, layer, x, y) end

---Docs: https://defold.com/ref/stable/tilemap/?q=tilemap.get_bounds#tilemap.get_bounds
---
---Get the bounds for a tile map. This function returns multiple values:
---The lower left corner index x and y coordinates (1-indexed),
---the tile map width and the tile map height.
---The resulting values take all tile map layers into account, meaning that
---the bounds are calculated as if all layers were collapsed into one.
---@param url string|hash|url the tile map
---@return number x x coordinate of the bottom left corner
---@return number y y coordinate of the bottom left corner
---@return number w number of columns (width) in the tile map
---@return number h number of rows (height) in the tile map
function tilemap.get_bounds(url) end

---Docs: https://defold.com/ref/stable/tilemap/?q=tilemap.set_visible#tilemap.set_visible
---
---Sets the visibility of the tilemap layer
---@param url string|hash|url the tile map
---@param layer string|hash name of the layer for the tile
---@param visible boolean should the layer be visible
function tilemap.set_visible(url, layer, visible) end

---flip tile horizontally
tilemap.H_FLIP = nil

---flip tile vertically
tilemap.V_FLIP = nil

---rotate tile 90 degrees clockwise
tilemap.ROTATE_90 = nil

---rotate tile 180 degrees clockwise
tilemap.ROTATE_180 = nil

---rotate tile 270 degrees clockwise
tilemap.ROTATE_270 = nil

