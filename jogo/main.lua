require "map"
require "camera"

function love.load(path)
	local chunk = love.filesystem.load("maps/"..path[1]..".lua")
	local result = chunk()
end

function love.update(dt)

end

function love.draw()

end