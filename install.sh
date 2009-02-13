#!/bin/sh -x 

# Répertoire de travail
SH_BASE="${SH_BASE:-`pwd`}"

#Scripts de live-helper
. "${LH_BASE:-/usr/share/live-helper}"/functions.sh

# $LS_BINARY: Image iso
# (Default: binary.iso)
LS_BINARY="${LS_BINARY:-binary.iso}"

if [ -z $1 ]
then
	Echo "Usage : ./install.sh /dev/sdX"
	exit 0
fi

# $LS_DEVICE: clé usb
# (Default: empty)
LS_DEVICE=$1
FS="true"

Echo "Device : ${LS_DEVICE}"

#SIZEISOB=`ls -i -l ${LS_BINARY} |awk {'print $6'}`
SIZEISOB=`stat -c %s ${LS_BINARY}`
Echo "Size of  iso : ${SIZEISOB} bytes"

CYLINDERSBY=`sfdisk -l  ${LS_DEVICE}|grep "Units = "|awk {'print $5'}` 2>&1
Echo "Number of Bytes/cylinders : ${CYLINDERSBY}"


SIZEISOC=$((($SIZEISOB/$CYLINDERSBY)+1))
Echo "Size of ISO : ${SIZEISOC} cylinders"

SIZEDEVC=`sfdisk -l -uS ${LS_DEVICE}|grep "Disk /"|awk {'print $3'}` 2>&1
Echo "Size of dev : ${SIZEDEVC} cylinders"

SIZE1=$(($SIZEDEVC-$SIZEISOC-30))
Echo "Size partition 1 : ${SIZE1} cylinders"

SIZE2=$(($SIZE1+1))
while true
do
        if [ $((${SIZE1}%4)) != "0" ]
        then
                SIZE1=$((${SIZE1}-1))
        else
                break
        fi
done
Echo "Size partition 1 adjust modulo 4 : ${SIZE1} cylinders"

#umount ${LS_DEVICE}"1" 2> /dev/null
umount ${LS_DEVICE}"1" | exit 0
umount ${LS_DEVICE}"2" | exit 0


Echo "Write partition table"

sfdisk ${LS_DEVICE} << EOF
0,${SIZE1},b
${SIZE2},,83,*
EOF

Echo "Re-read partition table"
partprobe -s 

if [[ $FS == true ]]
then
        Echo "Making filesystem"

        umount ${LS_DEVICE}1 | exit 0
        umount ${LS_DEVICE}2 | exit 0
        mkfs.vfat -F 32 ${LS_DEVICE}"1"
	mkfs.ext2 ${LS_DEVICE}"2" -L "satan"
fi

echo "############################"
Echo "Start copy of iso"
echo "############################"

TEMPMOUNT="$(mktemp -d -t live-mount.XXXXXXXX)"
TEMPISO="$(mktemp -d -t live-iso.XXXXXXXX)"

if [ -z ${TEMPMOUNT} ]
then
	Echo "Error TEMPMOUNT"
	exit 0
fi
if [ -z ${TEMPISO} ]
then
	Echo "Error TEMPISO"
	exit 0
fi

Echo "Making tempdir"

mkdir -p "${TEMPMOUNT}"
mkdir -p "${TEMPISO}"

Echo "Mounting device and binary"
mount -t ext2 ${LS_DEVICE}"2" "${TEMPMOUNT}"
mount -o loop ${LS_BINARY} "${TEMPISO}"

Echo "Copying binary"
cp -a "${TEMPISO}"/* "${TEMPMOUNT}"/

Echo "Installing Grub"
echo "(hd1) ${LS_DEVICE}" > ${TEMPMOUNT}/boot/grub/device.map

Echo "Device map"
cat ${TEMPMOUNT}/boot/grub/device.map

grub-install --root-directory=${TEMPMOUNT}  --no-floppy '(hd1)'


Echo "Unmounting device"
umount ${LS_DEVICE}2 | exit 0
umount ${LS_BINARY} |exit 0

Echo "Removing build directory"
rm -rf ${TEMPMOUNT}

Echo "Installation terminé"
