--[[
  This class is meant to generalize input handling without needing too many abstraction calls.
--]]

local InputManager = {}
InputManager.__index = InputManager

function InputManager:new()
  local o = {}

  -- the lists of classes that use love2d callbacks

  o.keypressed_list = {}
  o.mousepressed_list = {}
  o.touchpressed_list = {}
  o.touchreleased_list = {}

  setmetatable(o, self)
  return o
end

function InputManager:addKeyPressed(class) table.insert(self.keypressed_list, class) end

function InputManager:addMousePressed(class) table.insert(self.mousepressed_list, class) end

function InputManager:addTouchPressed(class) table.insert(self.touchpressed_list, class) end

function InputManager:addTouchReleased(class) table.insert(self.touchreleased_list, class) end

-- love2d callbacks

function InputManager:keypressed(key)
  for _, class in ipairs(self.keypressed_list) do
    class:keypressed(key)
  end
end

function InputManager:mousepressed(x, y, button)
  for _, class in ipairs(self.mousepressed_list) do
    class:mousepressed(x, y, button)
  end
end

function InputManager:touchreleased(id, x, y)
  for _, class in ipairs(self.touchreleased_list) do
    class:touchreleased(id, x, y)
  end
end

function InputManager:touchpressed(id, x, y)
  for _, class in ipairs(self.touchpressed_list) do
    class:touchpressed(id, x, y)
  end
end

return InputManager
