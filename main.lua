local GameManager = require("core.game_manager")

fmt = string.format

local game_manager = GameManager:new()

function love.load()
  game_manager:load()
end

function love.mousepressed(x, y, button)
  game_manager.ui_manager:mousepressed(x, y, button)
end

function love.update(dt)
  game_manager:update(dt)
end

function love.draw()
  game_manager:draw()
end
