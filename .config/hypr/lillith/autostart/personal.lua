local utils = require("lillith.utils")

utils.spawnOnOtherMonitor("discord")
utils.spawnOnOtherMonitor("astra")

--- @type AutostartExport
return {
  commands = {
    "kdeconnect-indicator",
    "flatpak run --user com.discordapp.Discord",
    "alacritty",
    utils.exists("/mnt/fuckshit/Music") and "env APPIMAGELAUNCHER_DISABLE=1 astra" or nil,
    utils.exists("/mnt/fuckshit/VRCX.sqlite3") and
      "env APPIMAGELAUNCHER_DISABLE=1 /home/lillith/Applications/VRCX.AppImage --startup" or
      nil
  }
}
