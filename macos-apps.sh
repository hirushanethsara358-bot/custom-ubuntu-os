#!/bin/bash
# Recommended macOS-like Apps & Tools Installer
set -e

echo "=== Installing macOS-like Apps & Utilities ==="

# Update package lists inside chroot
apt-get update

# Install sleek terminal utilities, neofetch, htop, curl, git, vlc, gedit/text editor
apt-get install -y \
    neofetch \
    htop \
    curl \
    git \
    vlc \
    btop \
    build-essential

# Configure Neofetch to show custom Apple / macOS logo representation
mkdir -p /etc/skel/.config/neofetch
cat << 'EOF' > /etc/skel/.config/neofetch/config.conf
print_info() {
    prin " macOS Ubuntu Edition"
    info "OS" distro
    info "Host" model
    info "Kernel" kernel
    info "Uptime" uptime
    info "Packages" packages
    info "Shell" shell
    info "Resolution" resolution
    info "DE" de
    info "WM" wm
    info "Theme" theme
    info "Icons" icons
    info "Terminal" term
    info "CPU" cpu
    info "GPU" gpu
    info "Memory" memory
}
EOF

echo "macOS-like apps and utilities installed successfully!"
