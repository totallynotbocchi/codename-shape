function love.load()
  print(love.audio.newSource("test.wav", "static"):play())
end
