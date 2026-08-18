hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("GTK_THEME", "Breeze-Dark")
--- @type AutostartExport
return {
  commands = {
    'gsettings set org.gnome.desktop.interface color-scheme "prefer-dark',
    'gsettings set org.gnome.desktop.interface gtk-theme "adw-gtk3-dark'
  }
}
