#!/bin/bash -x

#Scripts de live-helper
. "${LH_BASE:-/usr/share/live-helper}"/functions.sh

# $METHODE: Génération automatique ou manuel de la doc
# (Default: empty)
METHODE=$1

if [ "${METHODE}" = "auto" ]
then
	if [ ! -d "${SH_BASE}" ]
	then
		Echo "Utilisr ./doc make pour générer la documentation"
		exit 1;
	fi
	
	DOC_BASE="${SH_BASE}/doc"
	Echo "Construction de la documentation"
	
	cd ${DOC_BASE}/satan-manual
	dch --force-bad-version --newversion 1+00 --distribution Satan Manual $(date -R)
	dpkg-buildpackage -rfakeroot -us -uc
	debuild clean
	mkdir -p ${SH_BASE}/config/chroot_local-packages
	mv ${DOC_BASE}/satan*.deb ${SH_BASE}/config/chroot_local-packages

	cp -R ${DOC_BASE}/satan-manual/img/ ${DOC_BASE}/../config/chroot_local-includes/usr/share/doc/satan-manual/html/	
	cp -R ${DOC_BASE}/satan-manual/scripts/ ${DOC_BASE}/../config/chroot_local-includes/usr/share/doc/satan-manual/html/scripts/	
	cp -R ${DOC_BASE}/satan-manual/config/ ${DOC_BASE}/../config/chroot_local-includes/usr/share/doc/satan-manual/html/config/	
	rm -rf ${DOC_BASE}/satan-manual_*
	cd ${SH_BASE}

elif [ "${METHODE}" = "make" ]
then
	DOC_BASE="$(pwd)/../doc"
	cd ${DOC_BASE}/satan-manual
	make 
	Echo "La documentation est disponible dans /doc/satan-manual : index.html, satan-manual.pdf, satan-manual.txt"

elif [ "${METHODE}" = "clean" ]
then
	DOC_BASE="$(pwd)/../doc"
	cd ${DOC_BASE}/satan-manual
	make clean
	#rm -rf ${DOC_BASE}/../config/chroot_local-includes/usr/share/doc/satan-manual/html/img/*	
	rm -rf ${DOC_BASE}/satan-manual_*
#	rm -rf ${DOC_BASE}/../config/chroot_local-packages/satan-*
	# Nettoyage des annexes
	rm -rf ${DOC_BASE}/satan-manual/config/
	rm -rf ${DOC_BASE}/satan-manual/scripts/

else
	Echo "Usage : ./doc make|clean"	
fi
