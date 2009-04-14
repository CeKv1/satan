#!/bin/sh
echo "###################"
echo "####### 06 ########"
echo "###################"

echo "I: Correction de terminator"
 
# Suppression de l'alarme visuel
sed -i 's/# set bell-style none/set bell-style none/g' /etc/inputrc
