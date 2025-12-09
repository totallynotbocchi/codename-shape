local GameManager = require("core.game_manager")
local Logger = require("core.utils.logger")

fmt = string.format

-- create the game manager instance
local game_manager = GameManager:new()

-- love2d stuff

function love.load()
  Logger:init()
  game_manager:load()
end

function love.update(dt)
  game_manager:update(dt)
end

-- love2d callbacks
function love.mousepressed(x, y, button)
  game_manager.input_manager:mousepressed(x, y, button)
end

function love.touchreleased(id, x, y)
  game_manager.input_manager:touchreleased(id, x, y)
end

function love.keypressed(key)
  game_manager.input_manager:keypressed(key)
end

function love.touchpressed(id, x, y)
  game_manager.input_manager:touchpressed(id, x, y)
end

-- draw function yes yes
function love.draw()
  game_manager:draw()
end
