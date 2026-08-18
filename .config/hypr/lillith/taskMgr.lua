local TASKMGR_ALWAYS = true

hl.on(
  "hyprland.start",
  function()
    if TASKMGR_ALWAYS then
      hl.exec_cmd("alacritty --config-file /home/lillith/.config/alacritty/taskmgr.toml")
    end
  end
)

hl.window_rule(
  {
    name = "center-taskmgr",
    match = {class = "taskmgr"},
    float = true,
    size = {1600, 800},
    center = true,
    pin = true
  }
)
local taskmgr_hidden_rule =
  hl.window_rule(
  {
    name = "hide-taskmgr",
    match = {class = "taskmgr"},
    opacity = 0,
    no_focus = true
  }
)
taskmgr_hidden_rule:set_enabled(TASKMGR_ALWAYS)
hl.bind(
  require("lillith.binds").taskMgrBind,
  function()
    if not TASKMGR_ALWAYS then
      hl.exec_cmd("alacritty --config-file /home/lillith/.config/alacritty/taskmgr.toml")
    else
      taskmgr_hidden_rule:set_enabled(not taskmgr_hidden_rule:is_enabled())
    end
  end
)

hl.on(
  "window.close",
  ---@param window HL.Window
  function(window)
    if TASKMGR_ALWAYS and window.class == "taskmgr" then
      -- hide & respawn
      taskmgr_hidden_rule:set_enabled(true)
      hl.exec_cmd("alacritty --config-file /home/lillith/.config/alacritty/taskmgr.toml")
    end
  end
)
