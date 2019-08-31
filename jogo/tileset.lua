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
function tileset:new(tileset)
  local tileset_instance = {}
  setmetatable(tileset_instance, self)

  tileset_instance.name       = tileset.name
  tileset_instance.tilewidth  = tileset.tilewidth
  tileset_instance.tileheight = tileset.tileheight
  tileset_instance.spacing    = tileset.spacing
  tileset_instance.margin     = tileset.margin
  tileset_instance.columns    = tileset.columns
  tileset_instance.image      = love.graphics.newImage("tilesheets/"..tileset.image)
  tileset_instance.imagewidth = tileset.imagewidth
  tileset_instance.imageheight = tileset.imageheight
  tileset_instance.tileoffset = tileset.tileoffset

  tileset_instance:create_tiles()

  return tileset_instance
end

return tileset