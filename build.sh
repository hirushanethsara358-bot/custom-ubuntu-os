#!/bin/bash
set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
WORK_DIR="$SCRIPT_DIR/work"
OUTPUT_DIR="$SCRIPT_DIR/output"
ISO_PATH="$SCRIPT_DIR/ubuntu.iso"

echo "=== Custom Ubuntu ISO Builder ==="

if [ ! -f "$ISO_PATH" ]; then
    echo "Error: Ubuntu ISO not found at $ISO_PATH"
    echo "Please download or place your Ubuntu ISO at $ISO_PATH"
    exit 1
fi

echo "Creating working directories..."
mkdir -p "$WORK_DIR/iso" "$WORK_DIR/squashfs-root"

echo "Mounting base ISO..."
mkdir -p "$WORK_DIR/mnt"
sudo mount -o loop "$ISO_PATH" "$WORK_DIR/mnt"

echo "Copying ISO contents..."
rsync -a "$WORK_DIR/mnt/" "$WORK_DIR/iso/"
sudo umount "$WORK_DIR/mnt"

echo "Extracting squashfs..."
if [ -f "$WORK_DIR/iso/casper/filesystem.squashfs" ]; then
    SQUASHFS="$WORK_DIR/iso/casper/filesystem.squashfs"
elif [ -f "$WORK_DIR/iso/install/filesystem.squashfs" ]; then
    SQUASHFS="$WORK_DIR/iso/install/filesystem.squashfs"
else
    echo "Error: filesystem.squashfs not found in ISO!"
    exit 1
fi

sudo unsquashfs -f -d "$WORK_DIR/squashfs-root" "$SQUASHFS"

echo "Preparing chroot environment..."
sudo cp /etc/resolv.conf "$WORK_DIR/squashfs-root/etc/"
sudo mount --bind /dev "$WORK_DIR/squashfs-root/dev"
sudo mount --bind /proc "$WORK_DIR/squashfs-root/proc"
sudo mount --bind /sys "$WORK_DIR/squashfs-root/sys"

echo "Ready for customization!"
