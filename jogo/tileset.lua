local tileset = {}
tileset.__index = tileset

--Gera todos os Quads de um Tileset
function tileset:create_tiles()
  self.tiles = {}
  local image = self.image
  local width  = self.tilewidth
  local height = self.tileheight

  for y = 0, image:getHeight() - height, height do
    for x = 0, image:getWidth() - width, width do
      table.insert(self.tiles, love.graphics.newQuad(x, y, width, height, image:getDimensions()))
    end
  end

end

--Cria uma nova instancia de tileset
function tileset:new(tileset_info)
  local tileset_instance = {}
  setmetatable(tileset_instance, self)

  tileset_instance.name       = tileset_info.name
  tileset_instance.tilewidth  = tileset_info.tilewidth
  tileset_instance.tileheight = tileset_info.tileheight
  tileset_instance.spacing    = tileset_info.spacing
  tileset_instance.margin     = tileset_info.margin
  tileset_instance.columns    = tileset_info.columns
  tileset_instance.image      = love.graphics.newImage("tilesheets/"..tileset_info.image)
  tileset_instance.imagewidth = tileset_info.imagewidth
  tileset_instance.imageheight = tileset_info.imageheight
  tileset_instance.tileoffset = tileset_info.tileoffset

  tileset_instance:create_tiles()

  return tileset_instance
end

return tileset