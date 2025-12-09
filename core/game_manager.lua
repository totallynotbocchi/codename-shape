local SceneManager = require("core.scene_manager")
local UIManager = require("core.ui_manager")
local InputManager = require("core.input_manager")
local MainMenuScene = require("core.scenes.main_menu")
local Logger = require("core.utils.logger")
local TableUtils = require("core.utils.table")

local GameManager = {}
GameManager.__index = GameManager

function GameManager:new()
  local o = {}

  o.scene_manager = SceneManager:new()
  o.ui_manager = UIManager:new()
  o.input_manager = InputManager:new()

  if TableUtils.contains({ "Android", "iOS" }, love.system.getOS()) then
    Logger:info("Game manager detected mobile platform")
    o.input_manager:addTouchPressed(o.scene_manager)
    o.input_manager:addTouchReleased(o.ui_manager)
  else
    Logger:info("Game manager detected desktop platform")
    o.input_manager:addKeyPressed(o.scene_manager)
    o.input_manager:addMousePressed(o.ui_manager)
  end

  Logger:info("Game manager instance initialized")
  setmetatable(o, self)
  return o
end

function GameManager:load()
  -- load the main menu
  local main_menu = MainMenuScene:new()
  main_menu:load(self.ui_manager, self.scene_manager)

  self.scene_manager:addScene("main menu", main_menu)
  self.scene_manager:setCurrent("main menu")
end

-- NOTE: all order matters
function GameManager:draw()
  self.scene_manager:draw()
  self.ui_manager:draw()

  -- debug stuff
  love.graphics.setColor(0, 255, 0)
  love.graphics.print(fmt("FPS: %d", love.timer.getFPS()))
end

-- NOTE: order only matters for some things
function GameManager:update(dt)
  self.scene_manager:update(dt)
  self.ui_manager:update(dt)
end

return GameManager
