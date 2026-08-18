hl.window_rule(
  {
    name = "wayvr-uidev-float",
    match = {initial_title = "\\[-\\/=\\]: gui scale, F10: debug draw, F11: print tree"},
    float = true,
    -- no_focus = true,
    size = {450, 400},
    center = true
  }
)

hl.window_rule(
  {
    name = "tracker-software",
    match = {class = "(slimevr)|(SlimeTora)"},
    workspace = "name:Trackers"
  }
)

hl.window_rule(
  {
    name = "vr-application",
    match = {class = "(io.github.wivrn.wivrn)|(steam_app_438100)"},
    workspace = "name:VR Software"
  }
)
