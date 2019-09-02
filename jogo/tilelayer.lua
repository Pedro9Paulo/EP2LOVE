local tilelayer = {}
tilelayer.__index = tilelayer

function tilelayer:new(layer)
	local new_layer = {}
	setmetatable(new_layer, self)

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
	new_layer.visible = layer.visible

	return new_layer
end

function tilelayer:draw(tileset, tw, th)
	if self.visible then
		for y = 1, self.height, 1 do
			for x = 1, self.width, 1 do

				local tilex = (x - y) * tw/2
				local tiley = (x + y) * th/2 + self.z
				local tilei = (x + (y - 1) * self.height)
				local tile_type = self.data[tilei]

				if tile_type > 0 then
					love.graphics.draw(tileset.image, tileset.tiles[tile_type], tilex, tiley)
				end

			end
		end
	end
end

return tilelayer