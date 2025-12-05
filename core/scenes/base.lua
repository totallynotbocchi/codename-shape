local Scene = {}
Scene.__index = Scene

function Scene:new(type)
  local o = {}

  o.__type = type
  o.is_loaded = false

  setmetatable(o, self)
  return o
end

function Scene:load()
  error(fmt('Method "load" not implemented for type "%s"', self:getType()))
end

function Scene:getType()
  return self.__type
end

function Scene:draw()
  error(fmt('Method "draw" not implemented for type "%s"', self:getType()))
end

return Scene
