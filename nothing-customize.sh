#!/bin/bash
# Nothing OS Customization Script for Ubuntu
set -e

echo "=== Applying Nothing OS Customizations ==="

# 1. Set Wallpapers
WALLPAPER_DIR="/usr/share/backgrounds"
mkdir -p "$WALLPAPER_DIR"

# 2. Configure default GTK theme, icons, and GNOME settings if dconf/gsettings is available
if command -v gsettings &> /dev/null; then
    echo "Configuring GNOME desktop appearance..."
    # Set dark theme
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
    gsettings set org.gnome.desktop.interface gtk-theme 'Yaru-dark'
    gsettings set org.gnome.desktop.interface icon-theme 'Yaru-dark'
    
    # Set Nothing OS Wallpapers as default
    if [ -f "$WALLPAPER_DIR/nothing-wallpaper-1.png" ]; then
        gsettings set org.gnome.desktop.background picture-uri "file://$WALLPAPER_DIR/nothing-wallpaper-1.png"
        gsettings set org.gnome.desktop.background picture-uri-dark "file://$WALLPAPER_DIR/nothing-wallpaper-1.png"
    fi
fi

# 3. Create Nothing OS branding files / info
echo "Nothing OS (Ubuntu Edition)" > /etc/os-release
echo "NAME=\"Nothing OS\"" >> /etc/os-release
echo "PRETTY_NAME=\"Nothing OS (Ubuntu Custom)\"" >> /etc/os-release
echo "ID=nothingos" >> /etc/os-release
echo "ID_LIKE=ubuntu" >> /etc/os-release

echo "Nothing OS customizations applied successfully!"
