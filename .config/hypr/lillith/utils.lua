local monitors = require("lillith.monitors")

local export = {}

--- Gives a window rule that spawns new instances of that class on DISP2
--- @see monitors.DISP2
--- @param class string
--- @return HL.WindowRule
export.spawnOnOtherMonitor = function(class)
  return hl.window_rule(
    {
      name = "spawn-" .. class .. "-othermonitor",
      match = {class = class},
      monitor = monitors.DISP2,
      no_initial_focus = true
    }
  )
end

-- i hope this works
--- Check if a file or directiry exists at the given path
--- @param path string
--- @return boolean
export.exists = function(path)
  local ok, err, code = os.rename(path, path)
  if not ok then
    if code == 13 then
      -- Permission denied, but it exists
      return true
    end
    return false
  end
  return ok
end

return export
