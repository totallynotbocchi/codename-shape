local Logger = require("core.utils.logger")
local Note = require("core.note")

--[[
  This class manages all registered notes for the game to run
--]]

local NoteManager = {}
NoteManager.__index = NoteManager

function NoteManager:new()
  local o = {}

  -- list of notes
  o.notes = {}

  setmetatable(o, self)
  return o
end

function NoteManager:addNote(note)
  table.insert(self.notes, note)
end

function NoteManager:loadChart(json_content)
  -- load all the note objects
  for _, file_note in json_content.notes do
    table.insert(
      self.notes,
      Note:new(file_note.shape, file_note.x)
    )
  end

  return true
end

function NoteManager:update(dt, song_manager)
  for _, note in pairs(self.notes) do
    -- update their position
    note.y = (song_manager.pos - note.time) * song_manager.speed_scale

    -- check if they are hit
    if note:isInHitRange() then
      error("Fuck you nigga")
    end
  end
end

return NoteManager
