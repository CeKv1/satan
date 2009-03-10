#!/bin/sh 

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

Echo "Clef USB  : ${LS_DEVICE}"

SIZEISOB=`stat -c %s ${LS_BINARY}`
Echo "Taille de l'image iso  : ${SIZEISOB} bytes"

CYLINDERSBY=`sfdisk -l  ${LS_DEVICE}|grep "Units = "|awk {'print $5'}` 2>&1
Echo "Nombre de  Bytes/cylinders : ${CYLINDERSBY}"


SIZEISOC=$((($SIZEISOB/$CYLINDERSBY)+1))
Echo "Taille de l'image iso : ${SIZEISOC} cylinders"

SIZEDEVC=`sfdisk -l -uS ${LS_DEVICE}|grep "Disk /"|awk {'print $3'}` 2>&1
Echo "Taille de la clef USB : ${SIZEDEVC} cylinders"

SIZE1=$(($SIZEDEVC-$SIZEISOC-30))
Echo "Taille de la première partition : ${SIZE1} cylinders"

SIZE2=$(($SIZE1+1))
#while true
#do
#        if [ $((${SIZE1}%4)) != "0" ]
#        then
#                SIZE1=$((${SIZE1}-1))
#        else
#                break
#        fi
#done
#Echo "Size partition 1 adjust modulo 4 : ${SIZE1} cylinders"

umount ${LS_DEVICE}"1" | exit 0
umount ${LS_DEVICE}"2" | exit 0


Echo "Ecriture de la table de partition"

sfdisk ${LS_DEVICE} << EOF
0,${SIZE1},b
${SIZE2},,83,*
EOF

Echo "Re-lecture de la table de partition"
partprobe -s 

if [[ $FS == true ]]
then
        Echo "Partitionnement"

        umount ${LS_DEVICE}1 | exit 0
        umount ${LS_DEVICE}2 | exit 0
        mkfs.vfat -F 32 ${LS_DEVICE}"1"
	mkfs.ext2 ${LS_DEVICE}"2" -L "satan"
fi

partprobe -s

echo "################################"
Echo "## Début de la copie de l'iso ## "
echo "################################"

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

Echo "Création des répertoires temporaires"

mkdir -p "${TEMPMOUNT}"
mkdir -p "${TEMPISO}"

Echo "Montage des partitions"
Echo_warning "ATTENTION, si une erreur survient, il faut relancer tout le script install.sh"
mount -t ext2 ${LS_DEVICE}"2" "${TEMPMOUNT}"
mount -o loop ${LS_BINARY} "${TEMPISO}"

Echo "Copie de l'iso sur la clé"
cp -a "${TEMPISO}"/* "${TEMPMOUNT}"/

Echo "Installation de Grub"
echo "(hd1) ${LS_DEVICE}" > ${TEMPMOUNT}/boot/grub/device.map

Echo "Table de partition utilisée :"
cat ${TEMPMOUNT}/boot/grub/device.map

grub-install --root-directory=${TEMPMOUNT}  --no-floppy '(hd1)'


Echo "Démontage des périphériques"
umount ${LS_DEVICE}2 | exit 0
umount ${LS_DEVICE}1 | exit 0
umount ${LS_BINARY} |exit 0

Echo "Suppréssion des répertoires temporaires"
rm -rf ${TEMPMOUNT}

if [[ $FS == true ]]
then
        Echo "Making filesystem"
        mkfs.vfat -F 32 ${LS_DEVICE}"1"
fi

Echo "Installation terminé"
