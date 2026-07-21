#!/bin/bash
set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
WORK_DIR="$SCRIPT_DIR/work"
OUTPUT_DIR="$SCRIPT_DIR/output"
mkdir -p "$OUTPUT_DIR"
OUTPUT_ISO="$OUTPUT_DIR/custom-ubuntu.iso"

echo "=== Packing Custom Ubuntu ISO ==="

echo "Unmounting chroot binds..."
sudo umount "$WORK_DIR/squashfs-root/dev" || true
sudo umount "$WORK_DIR/squashfs-root/proc" || true
sudo umount "$WORK_DIR/squashfs-root/sys" || true

echo "Updating filesystem size and manifest..."
cd "$WORK_DIR/squashfs-root"
sudo chmod +w ../iso/casper/filesystem.manifest
sudo chroot . dpkg-query -W --showformat='${Package} ${Version}\n' > ../iso/casper/filesystem.manifest
sudo rm -f ../iso/casper/filesystem.squashfs

echo "Recompressing squashfs (this may take a few minutes)..."
sudo mksquashfs . ../iso/casper/filesystem.squashfs -comp xz -b 1M -Xbcj x86

echo "Updating filesystem size..."
printf $(du -sx --block-size=1 . | tail -1 | awk '\''{print $1}'\'') | sudo tee ../iso/casper/filesystem.size

echo "Generating final bootable ISO..."
cd "$WORK_DIR/iso"
sudo xorriso -as mkisofs \
    -iso-level 3 \
    -full-iso9660-filenames \
    -volid "CustomUbuntu" \
    -eltorito-boot boot/grub/i386-pc/eltorito.img \
    -eltorito-catalog boot/grub/i386-pc/boot.catalog \
    -no-emul-boot -boot-load-size 4 -boot-info-table \
    -eltorito-alt-boot \
    -e boot/grub/efi.img \
    -no-emul-boot \
    -output "$OUTPUT_ISO" \
    .

echo "Success! Custom ISO generated at: $OUTPUT_ISO"
