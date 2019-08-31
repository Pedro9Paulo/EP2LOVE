local map = require "map"
require "camera"

function love.load(path)
	local chunk = love.filesystem.load("maps/"..path[1]..".lua")
	local map_info = chunk()
	map:setup(map_info)
end

function love.update(dt)

end

function love.draw()
	local tileset = map.tilesets[1]
	for layer = 1, #map.tilelayers, 1 do
		for y = 0, map.height-1, 1 do
			for x = 1, map.width, 1 do

				local tw = map.tilewidth
				local th = map.tileheight

				local tilex = (x - y) * tw/2 + 1000
				local tiley = (x + y) * th/2 + map.tilelayers[layer].z
				local tilei = (x + y * map.height)
				local tile_type = map.tilelayers[layer].data[tilei]

				if tile_type > 0 then
					love.graphics.draw(tileset.image, tileset.tiles[tile_type], tilex, tiley, 0, 4)
				end

			end
		end
	end
end