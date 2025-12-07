local Vector2 = require("core.utils.vector2")
local Collisions = require("core.utils.collisions")

local Note = {}
Note.__index = Note
Note.__last_id = 0

-- each shape instance is of a certain type
-- this function does not create a shape type
function Note:new(shape, time, x)
  local o = {}

  Note.__last_id = Note.__last_id + 1
  o.id = Note.__last_id

  o.shape = shape

  o.time = time -- in milliseconds

  -- physical position
  o.x = x
  o.y = -100
  o.width = 50
  o.height = 40

  o.was_hit = false

  setmetatable(o, self)
  return o
end

function Note:update(dt)
end

function Note:isOnScreen()
  return Collisions.AABB2(
    self,
    {
      x = 0,
      y = 0,
      width = love.graphics.getWidth(),
      height = love.graphics.getHeight()
    }
  )
end

function Note:draw()
  if not self:isOnScreen() then return end

  love.graphics.push()

  love.graphics.setColor(255, 255, 255)
  love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)

  love.graphics.pop()
end

return Note
