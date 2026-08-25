--- @type AutostartExport
return {
  commands = {
    "hyprpaper", -- wallpaper
    "quickshell", -- applets
    "swaync", -- notifs
    "/usr/lib/hyprpolkitagent/hyprpolkitagent", -- perm prompts
    "wl-paste --type text --watch cliphist store",
    "wl-paste --type image --watch cliphist store",
    -- dark mode
    'gsettings set org.gnome.desktop.interface color-scheme "prefer-dark',
    'gsettings set org.gnome.desktop.interface gtk-theme "adw-gtk3-dark'
  }
}
