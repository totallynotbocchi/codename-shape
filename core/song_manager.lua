local Logger = require("core.utils.logger")

--[[
  This class manages the current song, how its played and other modifications
--]]

local SongManager = {}
SongManager.__index = SongManager

function SongManager:new(speed_scale)
  local o = {}

  o.speed_scale = speed_scale or 1
  o.pos = 0             -- time position in the song!! miiliseconds

  o.loaded_song = false -- any song is loaded
  o.source = nil        -- raw love2d audio

  setmetatable(o, self)
  return o
end

function SongManager:loadAudio(audio_path)
  -- load the song
  local ok, result = pcall(love.audio.newSource, audio_path, "stream")

  if not ok then
    Logger:err("Failed to load song file %s, message: %s", audio_path, result)

    self.source = nil -- make sure it keeps being nil
    self.loaded_song = false
    return false
  end

  Logger:info("Song file %s was loaded", audio_path)

  self.source = result
  self.loaded_song = true
  return true
end

-- dt is useless
function SongManager:update()
  if not self.loaded_song then return end

  self.pos = self.source:tell("seconds") * 1000
end

function SongManager:playCurrent()
  if not self.loaded_song then return end

  self.source:setVolume(1)
  local success = self.source:play()

  if not success then
    Logger:err("Failed to play audio.")
  end

  Logger:info("Started playing audio")
  return success
end

return SongManager
