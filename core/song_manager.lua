local Logger = require("core.utils.logger")

--[[
  This class manages the current song, how its played and other modifications
--]]

local SongManager = {}
SongManager.__index = SongManager

function SongManager:new(speed_scale)
  local o = {}

  o.speed_scale = speed_scale or 1
  o.pos = 0             -- time position in the song!!

  o.loaded_song = false -- any song is loaded
  o.source = nil        -- raw love2d audio

  setmetatable(o, self)
  return o
end

function SongManager:loadAudio(json_content)
  -- load the song
  self.source, err = love.audio.newSource(json_content.audio_file)

  if not self.source or err then
    Logger:err("Failed to load song file %s, message: %s", json_content.audio_file or "nil", err)
    return false
  end

  Logger:info("Song file %s was loaded", self.file_path)
  self.loaded_song = true
  return true
end

-- dt is useless
function SongManager:update(dt)
  if not self.loaded_song then return end

  self.pos = self.source:getPosition()
end

return SongManager
