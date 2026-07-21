#!/bin/bash
# macOS Login Screen & GDM Customization
set -e

echo "=== Configuring macOS-style Login & GDM Screen ==="

# Configure GDM3 background to use the sleek macOS wallpaper
GDM_CSS="/usr/share/gnome-shell/theme/gnome-shell.css"
if [ -f "$GDM_CSS" ]; then
    echo "Customizing GNOME Shell CSS for macOS login aesthetic..."
    # Add sleek styling rules for login background
    echo "" >> "$GDM_CSS"
    echo "/* macOS Style Customizations */" >> "$GDM_CSS"
    echo "#lockDialogGroup { background: #000000 url('resource:///org/gnome/shell/theme/macos-wallpaper-1.png') no-repeat; background-size: cover; }" >> "$GDM_CSS"
fi

echo "macOS Login screen aesthetic configured successfully!"
