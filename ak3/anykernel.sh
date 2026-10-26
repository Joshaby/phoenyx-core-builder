#!/sbin/sh

### AnyKernel3 Ramdisk Mod Script
## osm0sis @ xda-developers

### AnyKernel setup
properties() { '
kernel.string=TITLE
do.devicecheck=0
do.modules=0
do.systemless=0
do.cleanup=1
do.cleanuponabort=0
device.name1=
device.name2=
device.name3=
device.name4=
supported.versions=
supported.patchlevels=
'; }

### AnyKernel install
attributes() {
  set_perm_recursive 0 0 755 644 $RAMDISK/*
  set_perm_recursive 0 0 750 750 $RAMDISK/init* $RAMDISK/sbin
  chmod 755 $AKHOME/tools/keycheck 2>/dev/null
}

BLOCK=boot
IS_SLOT_DEVICE=1
RAMDISK_COMPRESSION=auto
PATCH_VBMETA_FLAG=auto

. tools/ak3-core.sh

attributes

DEVICE="$(getprop ro.product.device 2>/dev/null)"
[ -z "$DEVICE" ] && DEVICE="Unknown"

SLOT_NAME="${SLOT#_}"
[ -z "$SLOT_NAME" ] && SLOT_NAME="N/A"

ui_print "Device : $DEVICE"
ui_print "Slot   : $SLOT_NAME"
ui_print " "

ui_print "[1/3] Dumping boot image..."
split_boot

ui_print "[2/3] Flashing PhoenyxCore..."
flash_boot

ui_print "[3/3] Finalizing..."