#!/bin/sh
if [[ $1 = "backup" ]]
then
	echo "I: Sauvegarde des bases de données mysql"
	mysqldump -uroot -pbonjour --all-databases --add-drop-database=true > /home/etu/Desktop/documents/backup-$(date +%Y%m%d-%Hh%M).sql && echo "I: Toutes vos bases de données mysql ont été savegardé dans /home/yoyo/" && exit 0
	echo "La sauvegarde a échoué !" && exit 1
elif [[ $1 = "restore" ]]
then
	if [ -r $1 ]
	then
		echo "I: restauration des bases de données mysql"
		mysql -uroot -pbonjour < "$2" && echo "I: Base de donnée restauré" && exit 0
		echo "I: La restauration a échoué !"
	else
		echo "Le fichier $2 n'existe pas ou n'est pas accesible en lecture" && exit 1
	fi
else
	echo "Usages :"
	echo "Pour sauvegarder : ./backup-mysql.sh backup"
	echo "Pour restaurer   : ./backup-mysql.sh restore /path/du/fichier.sql"
	echo "Exemple          : ./backup-mysql.sh restore /home/etu/Desktop/backup/backup-20090211-03h51.sql"
	exit 1
fi
