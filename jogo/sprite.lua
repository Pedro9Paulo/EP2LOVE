local sprite = {}
sprite.__index = sprite

--Gera todos os Quads de um sprite
function sprite:create_frames()
  self.frames = {}
  local image = self.image
  local width  = image:getWidth()/self.properties.columns
  local height = image:getHeight()/self.properties.rows


  for y = 0, image:getHeight()-height, height do
    for x = 0, image:getWidth()-width, width do
      print(x,y,width,height)
      table.insert(self.frames, love.graphics.newQuad(x, y, width, height, image:getDimensions()))
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

--Cria uma nova instancia de sprite
function sprite:new(sprite)
  local sprite_instance = {}
  setmetatable(sprite_instance, self)

  sprite_instance.id = sprite.id
  sprite_instance.name = sprite.name
  sprite_instance.image = love.graphics.newImage("chars/"..sprite.name..".png")
  sprite_instance.type = sprite.type
  sprite_instance.x = sprite.x
  sprite_instance.y = sprite.y
  sprite_instance.width  = sprite.width
  sprite_instance.height = sprite.height
  sprite_instance.properties = sprite.properties

  sprite_instance:create_frames()
  sprite_instance:create_animation()

  return sprite_instance
end

return sprite