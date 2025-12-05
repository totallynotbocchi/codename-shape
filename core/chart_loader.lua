local json = require("vendor.json.json")
local Logger = require("core.utils.logger")

--[[
  This table is only responsible for loading a chart file
--]]

local ChartLoader = {}
ChartLoader.__index = ChartLoader

function ChartLoader:new(folder_path)
  local o = {}

  -- path to the level folder
  o.folder_path = folder_path

  setmetatable(o, self)
  return o
end

function ChartLoader:setPath(new_path)
  self.folder_path = new_path
end

function ChartLoader:load(note_manager, song_manager)
  -- try opening the json data file
  local file, err = love.filesystem.newFile(self.folder_path .. "/data.json", "r")
  if not file or err then
    Logger:err('Failed to load chart file "%s"', self.folder_path .. "/data.json")
    return false
  end

  local json_content = json.decode(file:read())
  Logger:info('Loading chart "%s"', json_content.name)

  -- load all the major managers with that jso

  if not note_manager:loadChart(json_content.notes) then
    Logger:err("Failed to load note manager")
    return false
  end

  if not song_manager:loadAudio(self.folder_path .. "/" .. json_content.audio_file) then
    Logger:err("Failed to load song manager")
    return false
  end

  return true
end

return ChartLoader
