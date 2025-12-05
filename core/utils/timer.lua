local Timer = {}
Timer.__index = Timer

function Timer:new(max)
  local o = {}

  self.current = 0
  self.max = max

  setmetatable(o, self)
  return o
end

function Timer:update(dt)
  self.current = math.min(self.max, self.current + dt)
end

function Timer:isDone()
  return self.current >= self.max
end

function Timer:reset()
  self.current = 0
end
