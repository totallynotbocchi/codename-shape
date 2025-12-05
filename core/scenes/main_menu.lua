local Scene = require("core.scenes.base")

local MainMenu = {}
MainMenu.__index = MainMenu

function MainMenu:new()
  local o = Scene:new("MainMenu")

  setmetatable(o, self)
  return o
end

function MainMenu:load()
  self.is_loaded = true
end

function MainMenu:draw()
  if not self.is_loaded then return end

  love.graphics.print("Hello", 10, 10)
end

function MainMenu:reset()
  self = MainMenu:new()
end

return MainMenu
