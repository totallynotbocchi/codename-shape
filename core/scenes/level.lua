local Scene = require("core.scenes.base")
local NoteManager = require("core.note_manager")
local SongManager = require("core.song_manager")
local ChartLoader = require("core.chart_loader")
local Logger = require("core.utils.logger")

local Level = {}
Level.__index = Level

function Level:new(level_path)
  local o = Scene:new("Level")

  o.chart_loader = ChartLoader:new(level_path)
  o.song_manager = SongManager:new()
  o.note_manager = NoteManager:new()

  setmetatable(o, self)
  return o
end

function Level:load(ui_manager)
  -- load scene UI
  ui_manager:createLayer("level")
  ui_manager:setCurrentLayer("level")

  -- load scene data!!
  Logger:info("Loading level...")
  if not self.chart_loader:load(self.note_manager, self.song_manager) then
    self.is_loaded = false
    return false
  end

  -- try playing the audio
  self.song_manager:playCurrent()

  -- return successfully
  Logger:info("Level was loaded")
  self.is_loaded = true
  return true
end

function Level:update(dt)
end

function Level:draw()
end

return Level
