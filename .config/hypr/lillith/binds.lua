local export = {}

export.mainMod = "SUPER"

-- hl.bind("ALT + Tab", hl.dsp.exec_cmd("snappy-switcher next --mod alt"))
hl.bind(export.mainMod .. " + D", hl.dsp.exec_cmd("helium-browser"))
hl.bind(export.mainMod .. " + L", hl.dsp.exec_cmd("qs ipc call memes toggle"))

export.taskMgrBind = "CTRL + SHIFT + ESCAPE"

hl.bind("insert", hl.dsp.exec_cmd("hyprshot -m region"))
hl.bind(export.mainMod .. " + ALT + C", hl.dsp.exec_cmd("hyprpicker -a -f hex"))

hl.bind(export.mainMod .. " + Q", hl.dsp.exec_cmd("alacritty"))
hl.bind(export.mainMod .. " + C", hl.dsp.window.close())

hl.bind(
  export.mainMod .. " + M",
  hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'")
)
hl.bind(export.mainMod .. " + E", hl.dsp.exec_cmd("nautilus"))
hl.bind(export.mainMod .. " + V", hl.dsp.window.float({action = "toggle"}))
hl.bind(export.mainMod .. " + R", hl.dsp.exec_cmd("hyprlauncher"))
hl.bind(export.mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(export.mainMod .. " + J", hl.dsp.layout("togglesplit")) -- dwindle only

-- Move focus with export.mainMod + arrow keys
hl.bind(export.mainMod .. " + left", hl.dsp.focus({direction = "left"}))
hl.bind(export.mainMod .. " + right", hl.dsp.focus({direction = "right"}))
hl.bind(export.mainMod .. " + up", hl.dsp.focus({direction = "up"}))
hl.bind(export.mainMod .. " + down", hl.dsp.focus({direction = "down"}))

-- Switch workspaces with export.mainMod + [0-9]
-- Move active window to a workspace with export.mainMod + SHIFT + [0-9]
for i = 1, 10 do
  local key = i % 10 -- 10 maps to key 0
  hl.bind(export.mainMod .. " + " .. key, hl.dsp.focus({workspace = i}))
  hl.bind(export.mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({workspace = i}))
end

-- -- Example special workspace (scratchpad)
-- hl.bind(export.mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
-- hl.bind(export.mainMod .. " + SHIFT + S", hl.dsp.window.move({workspace = "special:magic"}))

-- -- Scroll through existing workspaces with export.mainMod + scroll
-- hl.bind(export.mainMod .. " + mouse_down", hl.dsp.focus({workspace = "e+1"}))
-- hl.bind(export.mainMod .. " + mouse_up", hl.dsp.focus({workspace = "e-1"}))

-- Move/resize windows with export.mainMod + LMB/RMB and dragging
hl.bind(export.mainMod .. " + mouse:272", hl.dsp.window.drag(), {mouse = true})
hl.bind(export.mainMod .. " + mouse:273", hl.dsp.window.resize(), {mouse = true})

hl.bind(
  "XF86AudioRaiseVolume",
  hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
  {locked = true, repeating = true}
)
hl.bind(
  "XF86AudioLowerVolume",
  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
  {locked = true, repeating = true}
)
hl.bind(
  "XF86AudioMute",
  hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
  {locked = true, repeating = true}
)
hl.bind(
  "XF86AudioMicMute",
  hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
  {locked = true, repeating = true}
)

hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), {locked = true})
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), {locked = true})
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), {locked = true})
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), {locked = true})

return export
