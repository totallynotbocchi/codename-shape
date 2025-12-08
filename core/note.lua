local Logger = require("core.utils.logger")
local Collisions = require("core.utils.collisions")

local Note = {}
Note.__index = Note
Note.__last_id = 0

-- each shape instance is of a certain type
-- this function does not create a shape type
function Note:new(shape, key, time, x)
  local o = {}

  Note.__last_id = Note.__last_id + 1
  o.id = Note.__last_id

  o.key = key

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

-- useless optimization for the function below, might already be done by luajit tho
local window_box = {
  x = 0,
  y = 0,
  width = love.graphics.getWidth(),
  height = love.graphics.getHeight()
}

function Note:isOnScreen()
  return Collisions.AABB2(
    self,
    window_box
  )
end

function Note:hit()
  self.was_hit = true

  Logger:info(fmt('Note "%d" (with key %s) was hit.', self.id, self.key))
end

function Note:draw()
  if not self:isOnScreen() then return end

  -- draw the square
  if not self.was_hit then
    love.graphics.setColor(255, 255, 255)
  else
    love.graphics.setColor(0, 255, 0)
  end

  love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)

  -- draw the key
  love.graphics.setColor(0, 0, 0)
  love.graphics.print(self.key, self.x, self.y)
end

return Note
