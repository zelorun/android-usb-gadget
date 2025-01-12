#!/bin/sh

CONFIGFS_DIR="/config"
GADGETS_PATH="${CONFIGFS_DIR}/usb_gadget"

GADGET="keyboard"
GADGET_PATH=${GADGETS_PATH}/${GADGET}

CONFIG_PATH="$GADGET_PATH/configs/c.1/"
STRINGS_PATH="$GADGET_PATH/strings/0x409/"

mkdir -p $CONFIG_PATH
mkdir -p $STRINGS_PATH

mkdir -p $GADGET_PATH/functions/hid.usb0
cd $GADGET_PATH/functions/hid.usb0

# HID protocol (according to USB spec: 1 for keyboard)
echo 1 > protocol
# device subclass
echo 1 > subclass
# number of bytes per record
echo 8 > report_length

# writing report descriptor
echo -ne \\x05\\x01\\x09\\x06\\xa1\\x01\\x05\\x07\\x19\\xe0\\x29\\xe7\\x15\\x00\\x25\\x01\\x75\\x01\\x95\\x08\\x81\\x02\\x95\\x01\\x75\\x08\\x81\\x03\\x95\\x05\\x75\\x01\\x05\\x08\\x19\\x01\\x29\\x05\\x91\\x02\\x95\\x01\\x75\\x03\\x91\\x03\\x95\\x06\\x75\\x08\\x15\\x00\\x25\\x65\\x05\\x07\\x19\\x00\\x29\\x65\\x81\\x00\\xc0 > report_desc

mkdir -p $GADGET_PATH/functions/hid.usb1
cd $GADGET_PATH/functions/hid.usb1

# HID protocol (according to USB spec: 2 for mouse)
echo 2 > protocol
# device subclass
echo 1 > subclass
# number of bytes per record
echo 4 > report_length

# writing report descriptor
echo -ne \\x05\\x01\\x09\\x02\\xa1\\x01\\x09\\x01\\xa1\\x00\\x05\\x09\\x19\\x01\\x29\\x05\\x15\\x00\\x25\\x01\\x95\\x05\\x75\\x01\\x81\\x02\\x95\\x01\\x75\\x03\\x81\\x01\\x05\\x01\\x09\\x30\\x09\\x31\\x09\\x38\\x15\\x81\\x25\\x7F\\x75\\x08\\x95\\x03\\x81\\x06\\xc0\\xc0 > report_desc


cd $GADGET_PATH
echo 0x046a > idVendor
echo 0x002a > idProduct

cd $STRINGS_PATH
echo "CHERRY" > manufacturer
echo "Wireless Mouse & Keyboard" > product
echo "42" > serialnumber

cd $CONFIG_PATH
echo 120 > MaxPower
echo "HID Configuration" > strings/0x409/configuration

ln -s ${GADGET_PATH}/functions/hid.usb0 $CONFIG_PATH/hid.usb0
ln -s ${GADGET_PATH}/functions/hid.usb1 $CONFIG_PATH/hid.usb1
