local export = {}

export.DISP1 = "DP-3"
hl.monitor(
  {
    output = export.DISP1,
    mode = "1920x1080@60",
    position = "0x0",
    scale = "1"
  }
)
export.DISP2 = "HDMI-A-1"
hl.monitor(
  {
    output = export.DISP2,
    mode = "1920x1080@60",
    position = "900x-1080d",
    scale = "1"
  }
)

return export
