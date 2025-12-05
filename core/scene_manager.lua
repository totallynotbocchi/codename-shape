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
end

function SceneManager:draw()
  self.current_scene:draw()
end

return SceneManager
