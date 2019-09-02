local ts_creator = require "tileset"
local tl_creator = require "tilelayer"
local sp_creator = require "sprite"
local camera = require "camera"
local map = {}

function map:scan_group(layer)
	local z = 1+(#self.tilelayers)
	self.spritelayers[z] = {sprites = {}}

	for _, obj in pairs(layer.objects) do
		if(obj.type == "sprite") then
			local new_sprite = sp_creator:new(obj, map.tilewidth, map.tileheight, layer.offsety)
			table.insert(self.spritelayers[z].sprites, new_sprite)
		end

		if(obj.type == "camera") then
			camera:add_point(obj, map.tilewidth, map.tileheight, layer.offsety)
		end

	end

	for i,j in pairs(self.spritelayers) do print(i,j) end
end

function map:setup(info)
	--Basic Map Info
	self.width = info.width
	self.height = info.height
	self.tilewidth = info.tilewidth
	self.tileheight = info.tileheight
	self.nextlayerid = info.nextlayerid
	self.nextobjectid = info.nextobjectid
	local r = info.backgroundcolor[1]/255
	local g = info.backgroundcolor[2]/255
	local b = info.backgroundcolor[3]/255
	self.backgroundcolor = {r, g, b}

	--Tileset
	self.tilesets = {}
	for _,tileset in pairs(info.tilesets) do
		table.insert(self.tilesets, ts_creator:new(tileset))
	end

	--Layers
	self.tilelayers = {}
	self.spritelayers = {}
	camera:new()

	for _,layer in pairs(info.layers) do
		if(layer.type == "tilelayer") then
			local z = 1+(#self.tilelayers)
			self.tilelayers[z] = tl_creator:new(layer)
		end
		if(layer.type == "objectgroup") then self:scan_group(layer) end
	end

end

function map:update(dt)
	for _,splayer in pairs(self.spritelayers) do
		for _, sprite in pairs(splayer.sprites) do
			sprite:process_animation(dt)
		end
	end
	camera:update(dt, map.tilewidth, map.tileheight)
end

function map:draw()
	love.graphics.setDefaultFilter("nearest", "nearest")
	love.graphics.setBackgroundColor(self.backgroundcolor)
	camera:set()

	local tileset = self.tilesets[1]
	for layer = 1, math.max(#self.tilelayers, #self.spritelayers), 1 do

		self.tilelayers[layer]:draw(tileset, self.tilewidth, self.tileheight)

		if(self.spritelayers[layer] ~= nil) then
			for _, sprite in ipairs(self.spritelayers[layer].sprites) do
				sprite:draw()
			end
		end

	end

	camera.unset()
end

return map