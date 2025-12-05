local GameManager = require("core.game_manager")
local Logger = require("core.utils.logger")

fmt = string.format
local current_os = love.system.getOS()

if current_os == "Linux" then
  Logger:init("/tmp/cds_log.txt")
elseif current_os == "Android" then
  Logger:init("/sdcard/Download/cds_log.txt")
end

-- create the game manager instance
local game_manager = GameManager:new()

-- love2d stuff

function love.load()
  game_manager:load()
end

function love.mousepressed(x, y, button)
  if current_os ~= "Linux" and current_os ~= "Windows" and current_os ~= "OS X" then return end
  game_manager.ui_manager:mousepressed(x, y, button)
end

function love.touchreleased(id, x, y)
  if current_os ~= "Android" and current_os ~= "iOS" then return end
  game_manager.ui_manager:touchreleased(id, x, y)
end

function love.update(dt)
  game_manager:update(dt)
end

function love.draw()
  game_manager:draw()
end
