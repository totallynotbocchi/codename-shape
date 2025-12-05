local json = require("vendor.json.lua.json")
local Logger = require("core.utils.logger")

--[[
  This table is only responsible for loading a chart file
--]]

local ChartLoader = {}
ChartLoader.__index = ChartLoader

function ChartLoader:new(file_path)
  local o = {}

  o.file_path = file_path

  setmetatable(o, self)
  return o
end

function ChartLoader:setFilePath(new_path)
  self.file_path = new_path
end

function ChartLoader:load(note_manager, song_manager)
  -- try opening the chart json file
  local file, err = io.open(self.file_path, "r")
  if not file or err then
    Logger:err('Failed to load chart file "%s"', self.file_path)
    return false
  end

  -- load all the major managers with that json
  local json_content = json.decode(file:read("*a"))

  if not note_manager:loadChart(json_content) then
    Logger:err("Failed to load note manager")
    return false
  elseif not song_manager:loadAudio(json_content) then
    Logger:err("Failed to load song manager")
    return false
  end

  return true
end

return ChartLoader
