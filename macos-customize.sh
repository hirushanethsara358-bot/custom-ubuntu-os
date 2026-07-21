#!/bin/bash
# macOS (Apple Style) Customization Script for Ubuntu
set -e

echo "=== Applying Apple / macOS Style Customizations ==="

WALLPAPER_DIR="/usr/share/backgrounds"
mkdir -p "$WALLPAPER_DIR"

if command -v gsettings &> /dev/null; then
    echo "Configuring macOS-like desktop appearance..."
    # Dark mode & sleek theme
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
    gsettings set org.gnome.desktop.interface gtk-theme 'Yaru-dark'
    
    # Window buttons on the left (Apple style)
    gsettings set org.gnome.desktop.wm.preferences button-layout 'close,minimize,maximize:'
    
    # Set macOS style wallpapers as default
    if [ -f "$WALLPAPER_DIR/macos-wallpaper-1.png" ]; then
        gsettings set org.gnome.desktop.background picture-uri "file://$WALLPAPER_DIR/macos-wallpaper-1.png"
        gsettings set org.gnome.desktop.background picture-uri-dark "file://$WALLPAPER_DIR/macos-wallpaper-1.png"
    fi
fi

# Update OS Branding
echo "NAME=\"macOS Ubuntu Edition\"" > /etc/os-release
echo "PRETTY_NAME=\"macOS (Apple Style Custom Ubuntu)\"" >> /etc/os-release
echo "ID=macos-ubuntu" >> /etc/os-release
echo "ID_LIKE=ubuntu" >> /etc/os-release

echo "Apple / macOS style customizations applied successfully!"
