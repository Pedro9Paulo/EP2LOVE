local sprite = {}
sprite.__index = sprite

--Gera todos os Quads de um sprite
function sprite:create_frames()
	self.frames = {}
	local image = self.image
	local width = image:getWidth()/self.properties.columns
	local height = image:getHeight()/self.properties.rows


	for y = 0, image:getHeight()-height, height do
		for x = 0, image:getWidth()-width, width do
			local quad = love.graphics.newQuad(x, y, width, height, image:getDimensions())
			table.insert(self.frames, quad)
		end
	end

end

function sprite:create_animation()
	self.cur_frame = 1
	self.cur_duration = 0

	local anim_frames = {}

	for frame_token in self.properties.frames:gmatch("%d+") do
		table.insert(anim_frames, tonumber(frame_token))
	end

	self.properties.frames = anim_frames
end

function sprite:process_animation(dt)
	local fps = 1/self.properties.fps

	self.cur_duration = self.cur_duration + dt
	if self.cur_duration > fps then
			self.cur_frame = (self.cur_frame + 1)
			if self.cur_frame > #self.properties.frames then
				self.cur_frame = 1
			end
			self.cur_duration = self.cur_duration - fps
	end

end

function sprite:draw()
	if self.visible then
		local ox = self.properties.offsetx
		local oy = self.properties.offsety

		local frame = self.properties.frames[self.cur_frame]

		love.graphics.draw(self.image, self.frames[frame], self.x, self.y, 0, self.flip, 1, ox, oy)
	end
end

--Cria uma nova instancia de sprite
function sprite:new(sprite_info, tw, th, z)
	local sprite_instance = {}
	setmetatable(sprite_instance, self)

	sprite_instance.id = sprite_info.id
	sprite_instance.name = sprite_info.name
	sprite_instance.image = love.graphics.newImage("chars/"..sprite_info.name..".png")
	sprite_instance.type = sprite_info.type
	sprite_instance.properties = sprite_info.properties
	sprite_instance.visible = sprite_info.visible

	sprite_instance.width  = sprite_info.width
	sprite_instance.height = sprite_info.height

	local x = (sprite_info.x)/sprite_instance.width + 3
	local y = (sprite_info.y)/sprite_instance.height + 2

	sprite_instance.x = (x - y) * tw/2
	sprite_instance.y = (x + y) * th/2 + z

	sprite_instance.flip = 1
	if sprite_info.properties.flip then sprite_instance.flip = -1 end

	sprite_instance:create_frames()
	sprite_instance:create_animation()

	return sprite_instance
end

return sprite