local Collisions = require("core.utils.collisions")

local Button = {}
Button.__index = Button

function Button:new(x, y, w, h)
  local o = {}

  o.x = x
  o.y = y
  o.width = w
  o.height = h

  -- callbacks
  o.__click_callback = nil

  setmetatable(o, self)
  return o
end

function Button:setText(text)
  self.text = text
  return self
end

function Button:onClick(fn)
  self.__click_callback = fn
  return self
end

function Button:mousepressed(x, y, button)
  if Collisions.boxWithPoint(self, { x = x, y = y }) and button == 1 then
    self.__click_callback()
  end
end

function Button:update()
end

function Button:draw()
  love.graphics.push()

  love.graphics.setColor(200, 200, 200, 0.5)
  love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)

  -- draw text if any
  if self.text then
    love.graphics.setColor(255, 255, 255)
    love.graphics.print(self.text, self.x, self.y)
  end

  love.graphics.pop()
end

return Button
