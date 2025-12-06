local SceneManager = {}
SceneManager.__index = SceneManager

function SceneManager:new()
  local o = {}

  o.scenes = {} -- maps id to scene
  o.current_scene = nil

  setmetatable(o, self)
  return o
end

function SceneManager:addScene(id, scene)
  assert(scene.__type, fmt('Cannot add a non-scene (type is "%s").', type(scene)))

  self.scenes[id] = scene
end

function SceneManager:getScene(id)
  return self.scenes[id]
end

function SceneManager:setCurrent(id)
  local scene = self.scenes[id]
  assert(scene, "Scene does not exist.")

  self.current_scene = scene
end

function SceneManager:update(dt)
  if self.current_scene then self.current_scene:update(dt) end
end

function SceneManager:draw()
  if self.current_scene then self.current_scene:draw() end
end

return SceneManager
