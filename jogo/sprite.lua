local sprite = {}
sprite.__index = sprite

--Gera todos os Quads de um sprite
function sprite:create_frames()
  self.frames = {}
  local image = self.image
  local width  = image:getWidth()/self.properties.columns
  local height = image:getHeight()/self.properties.rows


  for y = 0, image:getHeight(), height do
    for x = 0, image:getWidth(), width do
      table.insert(self.frames, love.graphics.newQuad(x, y, width, height, image:getDimensions()))
    end
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

  return sprite_instance
end

return sprite