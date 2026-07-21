#!/bin/bash
# Advanced macOS (Apple Style) Ultimate Customization Script for Ubuntu
set -e

echo "=== Applying Ultimate Apple / macOS Style Customizations ==="

WALLPAPER_DIR="/usr/share/backgrounds"
mkdir -p "$WALLPAPER_DIR"

if command -v gsettings &> /dev/null; then
    echo "Configuring advanced macOS desktop appearance..."
    
    # 1. Dark Mode & High Contrast Apple Aesthetic
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
    gsettings set org.gnome.desktop.interface gtk-theme 'Yaru-dark'
    
    # 2. Window Controls on the Left (Apple macOS style)
    gsettings set org.gnome.desktop.wm.preferences button-layout 'close,minimize,maximize:'
    
    # 3. Font Settings (Clean Modern Sans - resembling San Francisco)
    gsettings set org.gnome.desktop.interface font-name 'Ubuntu 11'
    gsettings set org.gnome.desktop.interface document-font-name 'Ubuntu 11'
    gsettings set org.gnome.desktop.interface monospace-font-name 'Ubuntu Mono 13'
    
    # 4. Set Default macOS Wallpapers
    if [ -f "$WALLPAPER_DIR/macos-wallpaper-1.png" ]; then
        gsettings set org.gnome.desktop.background picture-uri "file://$WALLPAPER_DIR/macos-wallpaper-1.png"
        gsettings set org.gnome.desktop.background picture-uri-dark "file://$WALLPAPER_DIR/macos-wallpaper-1.png"
    fi
    
    # 5. Ubuntu Dock to macOS Bottom Dock behavior
    gsettings set org.gnome.shell.extensions.dash-to-dock dock-position 'BOTTOM'
    gsettings set org.gnome.shell.extensions.dash-to-dock extend-height false
    gsettings set org.gnome.shell.extensions.dash-to-dock transparency-mode 'FIXED'
    gsettings set org.gnome.shell.extensions.dash-to-dock background-opacity 0.2
    gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 48
fi

# 6. Update OS Branding to macOS
echo "NAME=\"macOS Sequoia (Ubuntu Edition)\"" > /etc/os-release
echo "PRETTY_NAME=\"macOS Sequoia (Apple Style Custom OS)\"" >> /etc/os-release
echo "ID=macos" >> /etc/os-release
echo "ID_LIKE=ubuntu" >> /etc/os-release
echo "HOME_URL=\"https://www.apple.com/macos/\"" >> /etc/os-release

echo "Ultimate Apple / macOS customizations applied successfully!"
