#!/bin/sh -x

DEST="/home/etu/Desktop/documents/conf-$(date +%Y%m%d-%Hh%M)"
ARRAY=( '/etc/apache2' '/var/www' '/etc/bind' '/etc/dhcp3' '/etc/gns3' '/etc/john' '/etc/nikto' '/etc/mysql' '/etc/php5' '/etc/puppet' '/etc/snmp' '/etc/ssh' '/etc/wireshark')

if [[ $1 = "backup" ]]
then
	if [[ -d $DEST ]]
	then
		echo "I: Sauvegarde des fichiers de configurations dans $DEST"
	else
		mkdir -v $DEST && echo "I: Création du répertoire $DEST"
		if [[ -d $DEST ]]
		then
			echo "I: Sauvegarde des fichiers de configurations dans $DEST"
		else
			echo "I: Création du répertoire $DEST impossible ! Abandon." && exit 1
		fi
	fi
	

	ELEMENTS=${#ARRAY[@]}
	for (( i=0;i<$ELEMENTS;i++))
	do
		if [[ -d ${ARRAY[${i}]} ]]
		then
			echo "I: Sauvegarde de : ${ARRAY[${i}]}"
			cp -a --parents  ${ARRAY[${i}]} $DEST && echo "I: Sauvegarde de ${ARRAY[${i}]} réussi"
		else
			echo "I: Le répertoire ${ARRAY[${i}]} n'existe pas"
		fi
	done	
elif [[ $1 = "restore" ]]
then
	if [[ -d $2 ]]
	then
		echo "Restauration des fichiers à partir de $2"
	else
		echo "Le répertoire $2 n'existe pas !" && exit 1
	fi
	
	cp -a $2/* /	
	#M="`echo "/home/bla" | tr  -d  /home/`"	
	

else
	echo "Usages :"
	echo "Pour sauvegarder : ./backup-conf.sh  backup"
	echo "Pour restaurer   : ./backup-conf.sh  restore /path/du/repertoire"
	echo "Exemple          : ./backup-conf.sh  restore $DEST"
	exit 1
fi
