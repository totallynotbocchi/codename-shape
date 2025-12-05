local Vector2 = {}
Vector2.__index = Vector2

function Vector2:new(x, y)
  local o = {
    x = x,
    y = y
  }

  setmetatable(o, self)
  return o
end

function Vector2:magnitude()
  return math.sqrt(self.x + self.y ^ 2)
end

-- returns a new vectoe
function Vector2:normalized()
  local mag = self:magnitude()

  return Vector2:new(self.x / mag, self.y / mag)
end

return Vector2
