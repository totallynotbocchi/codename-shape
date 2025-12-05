--[[
  This utilty contains methods to check for collisions.
--]]

local Collisions = {}

function Collisions.AABB2(box1, box2)
  return box1.x + box1.width >= box2.x and box2.x + box2.width >= box1.x
      and box1.y + box1.height >= box2.y and box2.y + box2.height >= box1.y
end

function Collisions.boxWithPoint(box, point)
  return box.x + box.width >= point.x and point.x >= box.x
      and box.y + box.height >= point.y and point.y >= box.y
end

return Collisions
