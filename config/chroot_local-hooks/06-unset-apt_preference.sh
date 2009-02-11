#!/bin/sh -x

echo "###################"
echo "####### 06 ########"
echo "###################"
cat /etc/apt/sources.list
echo "I: restauration des sources"

rm -f /etc/apt/sources.list
mv /etc/apt/sources2.list /etc/apt/sources.list

cat /etc/apt/sources.list

#cat > /etc/apt/sources.list << EOF
#deb http://localhost:9999/debian lenny main contrib non-free
#deb http://localhost:9999/security lenny/updates main contrib non-free
#
## Local packages
#deb file:/root/local-packages ./
#EOF

echo "I: Mise à jour des préférences"

rm -f /etc/apt/preferences

#apt-get update
