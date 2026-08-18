--- @alias AutostartExport { commands: string[]}

--- debug via require('/home/lillith/.config/hypr/lillith/autostart')(true)
--- @param dry boolean | nil
local function runAutostart(dry)
  dry = dry or false
  local files = require("/home/lillith/.config/hypr/lillith/autostart/*")
  for _, file in pairs(files) do
    if file["commands"] then
      for _, command in pairs(file.commands) do
        if dry then
          print("autostart: dryrunning " .. command)
        else
          print("autostart: running: " .. command)
          hl.exec_cmd(command)
        end
      end
    end
  end
end

hl.on("hyprland.start", runAutostart)

return runAutostart
