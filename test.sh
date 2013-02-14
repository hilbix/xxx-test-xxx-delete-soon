#!/bin/sh

KEY=/dev/disk/by-id/usb-Generic_STORAGE_DEVICE_000000009451-0:0-part1
LEN=512

out()
{
echo "$*" >&2
}

out "Loading USB"
modprobe usb_storage
out "Waiting for USB to come up"
sleep 10
if [ -b "$KEY" ]
then
	out "Unlocking LUKS with $KEY"
	exec dd if="$KEY" bs="$LEN" count=1 2>/dev/null
fi

out "Failed to detect $KEY"
exec /lib/cryptsetup/askpass "LUKS password: "
