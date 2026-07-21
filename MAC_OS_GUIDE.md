# 🍎 Ultimate Apple macOS Style Custom Ubuntu Guide

This guide explains how your Custom Ubuntu OS is transformed into a gorgeous **Apple macOS (Sequoia / Sonoma)** experience.

## ✨ Features Included:
1. **macOS Wallpapers:** High-resolution minimalist abstract macOS fluid gradients (`macos-wallpaper-1.png`, `macos-wallpaper-2.png`).
2. **Window Controls on the Left:** Close, minimize, and maximize buttons positioned on the top-left just like macOS.
3. **Bottom Dock Layout:** The Ubuntu dock is automatically shifted to the bottom and styled like the macOS Dock with transparency.
4. **Dark Mode & Sleek Aesthetics:** Configured with clean modern fonts and dark appearance.
5. **System Branding:** OS name updated to **macOS Sequoia (Ubuntu Edition)**.

---

## 🚀 How to Build and Apply:
1. Place your base Ubuntu ISO at:
   `/home/user/ubuntu-builder/ubuntu.iso`
2. Run the builder script:
   ```bash
   cd /home/user/ubuntu-builder
   ./build.sh
   ```
3. Chroot into the environment and run the macOS customizer:
   ```bash
   sudo chroot work/squashfs-root
   bash /home/user/ubuntu-builder/macos-customize.sh
   exit
   ```
4. Pack your final ISO:
   ```bash
   ./pack.sh
   ```
5. Find your custom macOS ISO at:
   `/home/user/ubuntu-builder/output/custom-ubuntu.iso`
