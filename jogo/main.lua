local map = require "map"
require "camera"
local map_info = require "maps/test"

function love.load(path)
	--local chunk = love.filesystem.load("maps/"..path[1]..".lua")
	--local map_info = chunk()
	map:setup(map_info)
end

function love.update(dt)

end
