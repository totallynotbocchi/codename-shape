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

  o.time = time

  -- physical position
  o.pos = Vector2:new(x, -100)

  o.was_hit = false
  o.visible = false

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

-- TODO: implement ts
function Note:draw()
  if not self.visible then
    error("Draw note not implemented")
  end
end

return Note
