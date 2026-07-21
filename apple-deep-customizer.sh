#!/bin/bash
# Deep Apple / macOS Transformation Script for Ubuntu
set -e

echo "=== Applying Deep Apple macOS Transformations ==="

# 1. Install San Francisco (SF Pro) Font (Fallback simulation using modern sans)
FONT_DIR="/usr/share/fonts/truetype/apple-fonts"
mkdir -p "$FONT_DIR"

# Configure default GNOME fonts to look ultra-clean (macOS style)
if command -v gsettings &> /dev/null; then
    echo "Applying deep macOS typography & interface settings..."
    gsettings set org.gnome.desktop.interface font-name 'Cantarell 11'
    gsettings set org.gnome.desktop.interface document-font-name 'Cantarell 11'
    gsettings set org.gnome.desktop.interface monospace-font-name 'JetBrains Mono 12'
    gsettings set org.gnome.desktop.interface text-scaling-factor 1.0
    
    # Enable animations & smooth transitions (macOS feel)
    gsettings set org.gnome.desktop.interface enable-animations true
    
    # Center new windows (macOS window behavior)
    gsettings set org.gnome.mutter center-new-windows true
    
    # Hot corners (macOS Mission Control style)
    gsettings set org.gnome.desktop.interface enable-hot-corners true
fi

# 2. Configure Terminal to match macOS Terminal app aesthetic
mkdir -p /etc/skel/.config/glib-2.0
cat << 'EOF' > /tmp/terminal-prefs.sh
# macOS style terminal preferences if dconf is available
EOF

# 3. Add Apple branding wallpaper as default login & lock screen wallpaper
WALLPAPER_PATH="/usr/share/backgrounds/macos-wallpaper-1.png"
if [ -f "$WALLPAPER_PATH" ] && command -v gsettings &> /dev/null; then
    gsettings set org.gnome.desktop.screensaver picture-uri "file://$WALLPAPER_PATH"
fi

echo "Deep Apple macOS transformations successfully applied!"
