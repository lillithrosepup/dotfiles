local TASKMGR_ALWAYS = true

hl.on(
  "hyprland.start",
  function()
    if TASKMGR_ALWAYS then
      hl.exec_cmd("alacritty --config-file /home/lillith/.config/alacritty/btop.toml")
    end
  end
)

local btop_hidden_rule =
  hl.window_rule(
  {
    name = "hide-btop",
    match = {class = "btop"},
    opacity = 0,
    no_focus = true
  }
)
btop_hidden_rule:set_enabled(TASKMGR_ALWAYS)
hl.bind(
  require("lillith.binds").taskMgrBind,
  function()
    if not TASKMGR_ALWAYS then
      hl.exec_cmd("alacritty --config-file /home/lillith/.config/alacritty/btop.toml")
    else
      btop_hidden_rule:set_enabled(not btop_hidden_rule:is_enabled())
    end
  end
)

hl.window_rule(
  {
    name = "btop",
    match = {class = "btop"},
    float = true,
    size = {1600, 800},
    center = true,
    pin = true
  }
)
