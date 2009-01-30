#!/bin/sh -x

# Répertoire de travail
SH_BASE="${SH_BASE:-`pwd`}"

#Scripts de live-helper
. "${LH_BASE:-/usr/share/live-helper}"/functions.sh

# $MIRROR: Utilisation d'un mirror local
# (Default: no)
MIRROR="yes"

if [ "${MIRROR}" = "yes" ]
then
	MIRROR_DEBIAN="http://localhost:9999/debian/"
	MIRROR_SECURITY="http://localhost:9999/security/"
else
	MIRROR_DEBIAN="http://ftp.fr.debian.org/debian/"
	MIRROR_SECURITY="http://ftp.ch.debian.org/debian-security/"
fi

lh_config \
	--initramfs live-initramfs \
	--mirror-bootstrap ${MIRROR_DEBIAN} \
	--mirror-binary http://ftp.fr.debian.org/debian/ \
	--mirror-binary-security http://ftp.ch.debian.org/debian-security/ \
	--mirror-chroot ${MIRROR_DEBIAN} \
	--mirror-chroot-security ${MIRROR_SECURITY} \
	--verbose \
	${@}
