local Scene = require("core.scenes.base")
local LevelScene = require("core.scenes.level")

local ButtonUI = require("core.ui.button")

local MainMenu = {}
MainMenu.__index = MainMenu

function MainMenu:new()
  local o = Scene:new("MainMenu")

  setmetatable(o, self)
  return o
end

function MainMenu:load(ui_manager, scene_manager)
  -- load the main menu UI
  ui_manager:createLayer("main menu")
  ui_manager:setCurrentLayer("main menu")

  -- test element
  ui_manager:addElement(
    "main menu",
    ButtonUI
    :new(10, 10, 200, 200)
    :setText("hello")
    :onClick(function()
      local level_scene = LevelScene:new("songs/test")
      level_scene:load(ui_manager)

      scene_manager:addScene("level", level_scene)
      scene_manager:setCurrent("level")
    end)
  )
end

function MainMenu:draw()
  love.graphics.print("Hello", 10, 10)
end

function MainMenu:reset()
  self = MainMenu:new()
end

return MainMenu
