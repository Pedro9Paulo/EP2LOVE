local camera = {}

function camera:add_point(point, tw, th, z)

	local x = (point.x)/point.width + 3
	local y = (point.y)/point.height + 2
	local camx = (x - y) * tw/2 - love.graphics.getWidth()/2
	local camy = (x + y) * th/2 + z - love.graphics.getHeight()/2

	local camera_point = {}

	camera_point.x = camx
	camera_point.y = camy
	camera_point.rotation = point.rotation
	camera_point.duration = point.properties.duration

	self.points[tonumber(point.name)] = camera_point

	if tonumber(point.name) == 1 then self:first_point() end
end

function camera:first_point()
	self.x = self.points[1].x
	self.y = self.points[1].y
	self.rotation = self.points[1].rotation
	if self.points[1].scale ~= nil then
		self.scale = self.points[1].scale
	end
end

function camera:update(dt)
	self.move.passed = self.move.passed + dt

	local next_point = self.move.cur_point + 1
	if next_point > #self.points then next_point = 1 end

	local duration = self.points[next_point].duration
	local progress = self.move.passed/duration

	if progress > 1 then progress = 1 end

	self.x = math.floor(self.points[next_point].x*progress + self.points[self.move.cur_point].x*(1-progress))
	self.y = math.floor(self.points[next_point].y*progress + self.points[self.move.cur_point].y*(1-progress))

	if progress == 1 then
		self.move.cur_point = next_point
		self.move.passed = 0
	end

end

function camera:set()
	love.graphics.push()
	love.graphics.rotate(-self.rotation)
	love.graphics.scale(self.scale[1], self.scale[2])
	love.graphics.translate(-self.x, -self.y)
end

function camera.unset()
	love.graphics.pop()
end

function camera:new()
	self.x = 0
	self.y = 0
	self.rotation = 0
	self.scale = {1,1}

	self.move = {}
	self.move.cur_point = 1
	self.move.passed = 0

	self.points = {}
end

return camera