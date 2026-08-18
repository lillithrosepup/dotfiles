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

return export
