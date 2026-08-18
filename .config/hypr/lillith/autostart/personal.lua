local utils = require("lillith.utils")

utils.spawnOnOtherMonitor("discord")
utils.spawnOnOtherMonitor("astra")

--- @type AutostartExport
return {
  commands = {
    "flatpak run --user com.discordapp.Discord",
    "env APPIMAGELAUNCHER_DISABLE=1 astra",
    "alacritty"
  }
}
