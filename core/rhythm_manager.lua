--[[
  This class uses the input manager and beat manager to judge the player's timing
--]]

local RhythmManager = {}
RhythmManager.__index = RhythmManager

function RhythmManager:new()
  local o = {}

  setmetatable(o, self)
  return o
end

return RhythmManager
