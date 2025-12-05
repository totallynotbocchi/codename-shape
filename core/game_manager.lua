local SceneManager = require("core.scene_manager")
local MainMenuScene = require("core.scenes.main_menu")
local UIManager = require("core.ui_manager")
local Logger = require("core.utils.logger")

local ButtonUI = require("core.ui.button")

local GameManager = {}
GameManager.__index = GameManager

function GameManager:new()
  local o = {}

  o.scene_manager = SceneManager:new()
  o.ui_manager = UIManager:new()

  Logger:info("Game manager instance initialized")
  setmetatable(o, self)
  return o
end

function GameManager:load()
  -- load the main menu
  local main_menu = MainMenuScene:new()
  main_menu:load()

  self.scene_manager:addScene("main menu", main_menu)
  self.scene_manager:setCurrent("main menu")

  -- load the main menu UI
  self.ui_manager:createLayer("main menu")
  self.ui_manager:setCurrentLayer("main menu")

  self.ui_manager:addElement( -- test element
    "main menu",
    ButtonUI
    :new(10, 10, 200, 200)
    :setText("hello")
    :onClick(function() print("hi") end)
  )
end

-- NOTE: all order matters
function GameManager:draw()
  self.scene_manager:draw()
  self.ui_manager:draw()
end

-- NOTE: order only matters for some things
function GameManager:update(dt)
  self.scene_manager:update(dt)
  self.ui_manager:update(dt)
end

return GameManager
