#!/bin/sh -x

echo "###################"
echo "####### 04 ########"
echo "###################"

echo "I: Sauvegarde des sources"
cat /etc/apt/sources.list
mv /etc/apt/sources.list /etc/apt/sources2.list
cat /etc/apt/sources2.list

echo "I: Mise à jour des sources"

cat > /etc/apt/sources.list << EOF1
## sid
deb http://ftp.fr.debian.org/debian/ sid main contrib non-free
deb-src http://ftp.fr.debian.org/debian/ sid main contrib non-free

## lenny
deb http://ftp.fr.debian.org/debian/ testing main contrib non-free
deb-src http://ftp.fr.debian.org/debian/ testing main contrib non-free
# security
deb http://security.debian.org/ lenny/updates main contrib non-free
deb-src http://security.debian.org/ lenny/updates main contrib non-free
EOF1

echo "I: Mise à jour des préférences"

cat > /etc/apt/preferences << EOF2
Package: *
Pin: release a=testing
Pin-Priority: 900

Package: *
Pin: release a=unstable
Pin-Priority: 800

Package: *
Pin: release o=Debian
Pin-Priority: -10
EOF2

cat /etc/apt/preferences

echo "I: Mise à jour"
apt-get update
apt-get -y dist-upgrade
