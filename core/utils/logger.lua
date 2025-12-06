local Logger = {
  enabled = true,
  filepath = nil
}

function Logger:init()
  local current_os = love.system.getOS()
  if current_os == "Linux" then
    self.filepath = os.getenv("HOME") .. "/cds_log.txt"
  elseif current_os == "Android" then
    self.filepath = "/sdcard/Download/cds_log.txt"
  end

  -- empty or create the log file
  io.open(self.filepath, "w")
  print("File created.")
end

function Logger:log(msg, ...)
  if not self.enabled then return end

  local info = debug.getinfo(3)
  local str = fmt(
    "(%s:%s:%d at %s): %s",
    info.source:match("[^/]*.lua$"), -- file name
    info.name,
    info.currentline,
    os.date("%X"), -- just current time
    fmt(msg, ...)
  )

  -- print the message
  print(str)

  -- also write it to the file if present
  if self.filepath then
    local file, err = io.open(self.filepath, "a+")
    if not file then error("Error opening log file: " .. err) end

    file:write(str, "\n")
    file:close()
  end
end

-- cute colors :3

function Logger:info(msg, ...)
  io.write("\27[96m[INFO] \27[0m")
  self:log(msg, ...)
end

function Logger:err(msg, ...)
  io.write("\27[31m[ERR] \27[0m")
  self:log(msg, ...)
end

function Logger:warn(msg, ...)
  io.write("\27[93m[WARN] \27[0m")
  self:log(msg, ...)
end

return Logger
