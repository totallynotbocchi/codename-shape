local Logger = require("core.utils.logger")

--[[
  This class manages the beats in a song and shows them to the player
--]]

local BeatManager = {}
BeatManager.__index = BeatManager

function BeatManager:new(bpm, margin)
  local o = {}

  o.bpm = bpm
  o.beat_duration_ms = 60 / bpm * 1000 -- one minute/beats per minute
  o.last_beat = 0

  o.error_margin = margin -- in milliseconds

  -- the duration between each beat, constant
  o.next_beat_pos = o.beat_duration_ms

  setmetatable(o, self)
  return o
end

--[[
function BeatManager:isHitOnBeat(song_manager)
  return song_manager.pos <= self.next_beat_pos - self.margin
end
--]]

function BeatManager:update(song_manager)
  if song_manager.pos >= self.next_beat_pos then
    self.last_beat = self.last_beat + 1
    self.next_beat_pos = self.next_beat_pos + self.beat_duration_ms
  end
end

return BeatManager
