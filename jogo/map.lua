local ts_creator = require "tileset"
local map = {}

function map:new_tilelayer(layer)
	local new_layer = {}
  	local z = 1+((self.tileheight - layer.offsety)/self.tileheight)

    new_layer.name = layer.name 
    new_layer.x = layer.x
    new_layer.y = layer.y
    new_layer.width = layer.width
    new_layer.height = layer.height
    new_layer.visible = layer.visible
    new_layer.opacity = layer.opacity
    new_layer.offsetx = layer.offsetx
    new_layer.z = layer.offsety
    new_layer.data = layer.data

  	self.tilelayers[z] = new_layer
end

function map:setup(info)
  --Basic Map Info
  self.width = info.width
  self.height = info.height
  self.tilewidth = info.tilewidth
  self.tileheight = info.tileheight
  self.nextlayerid = info.nextlayerid
  self.nextobjectid = info.nextobjectid
  self.backgroundcolor = info.backgroundcolor

  --Tileset
  self.tilesets = {}
  for _,tileset in pairs(info.tilesets) do
  	table.insert(self.tilesets, ts_creator:new(tileset))
  end

  --Layers
  self.tilelayers = {}
  self.objlayers = {}
  for _,layer in pairs(info.layers) do
  	if(layer.type == "tilelayer") then self:new_tilelayer(layer) end
  end

end

return map