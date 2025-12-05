local Scene = require("core.scenes.base")
local NoteManager = require("core.note_manager")
local SongManager = require("core.song_manager")
local Timer = require("core.utils.timer")

local Level = {}
Level.__index = Level

function Level:new()
  local o = Scene:new("Level")

  o.song_manager = SongManager:new("./songs/test.wav")
  o.note_manager = NoteManager:new()

  o.delayer = Timer:new(2)

  setmetatable(o, self)
  return o
end

-- load scene data!!
function Level:load()
  if not self.song_manager:load() then
    self.is_loaded = false
    return
  end

  self.is_loaded = true
end

function Level:update(dt, scene_manager)
  self.delayer:update(dt)

  if self.delayer:isDone() then
    scene_manager:setCurrent("main menu")
    self.delayer:reset()
  end
end
