local Logger = require("core.utils.logger")

local UIManager = {}
UIManager.__index = UIManager

function UIManager:new()
  local o = {}

  o.current_layer = nil -- a string
  o.layers = {}         -- maps an id to a layer, which is an array of elements

  setmetatable(o, self)
  return o
end

function UIManager:createLayer(id)
  Logger:info('Created new layer "%s"', id)
  self.layers[id] = {}
end

-- this might be used less often
function UIManager:getLayer(id)
  return self.layers[id]
end

function UIManager:setCurrentLayer(id)
  Logger:info('Switched current UI layer from "%s" to "%s"', self.current_layer, id)
  self.current_layer = id
end

-- returns the raw table
function UIManager:getCurrentLayer()
  return self.layers[self.current_layer]
end

function UIManager:addElement(id, element)
  table.insert(self.layers[id], element)
end

function UIManager:update(dt)
  for _, element in pairs(self:getCurrentLayer()) do
    element:update(dt)
  end
end

function UIManager:mousepressed(x, y, button)
  for _, element in pairs(self:getCurrentLayer()) do
    element:mousepressed(x, y, button)
  end
end

function UIManager:touchreleased(id, x, y)
  for _, element in pairs(self:getCurrentLayer()) do
    element:touchreleased(id, x, y)
  end
end

function UIManager:draw()
  for _, element in pairs(self:getCurrentLayer()) do
    element:draw()
  end
end

return UIManager
