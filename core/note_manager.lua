local Logger = require("core.utils.logger")
local Note = require("core.note")
local Collisions = require("core.utils.collisions")

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

function NoteManager:loadChart(note_list)
  -- load all the note objects
  for _, file_note in ipairs(note_list) do
    -- check if the json object has the needed data
    if not file_note.shape or not file_note.x or not file_note.time or not file_note.key then
      Logger:err("The note object in the JSON is lacking essential information")
      return false
    end

    -- add the new note
    self:addNote(Note:new(file_note.shape, file_note.key, file_note.time, file_note.x))
  end

  Logger:info("Note objects were loaded")
  return true
end

function NoteManager:update(song_manager)
  for _, note in ipairs(self.notes) do
    -- update their position
    note.y = (song_manager.pos - note.time) * song_manager.speed_scale
  end
end

function NoteManager:keypressed(key)
  for _, note in ipairs(self.notes) do
    if note.was_hit or note.key ~= key then
      goto continue
    end

    note:hit()
    ::continue::
  end
end

function NoteManager:touchpressed(id, x, y)
  for _, note in ipairs(self.notes) do
    if note.was_hit or not Collisions.boxWithPoint(note, { x = x, y = y }) then
      goto continue
    end

    note:hit()
    ::continue::
  end
end

function NoteManager:draw()
  for _, note in ipairs(self.notes) do
    note:draw()
  end
end

return NoteManager
