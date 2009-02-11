#/bin/sh -x

echo "I: Mise à jour des sources"

cat <<EOF > /etc/apt/sources.list
## sid
deb http://ftp.fr.debian.org/debian/ sid main contrib non-free
deb-src http://ftp.fr.debian.org/debian/ sid main contrib non-free

## lenny
deb http://ftp.fr.debian.org/debian/ testing main contrib non-free
deb-src http://ftp.fr.debian.org/debian/ testing main contrib non-free
# security
deb http://security.debian.org/ lenny/updates main contrib non-free
deb-src http://security.debian.org/ lenny/updates main contrib non-free
EOF

echo "I: Mise à jour des préférences"

cat <<EOF > /etc/apt/preferences
Package: *
Pin: release a=testing
Pin-Priority: 900

Package: *
Pin: release a=unstable
Pin-Priority: 800

Package: *
Pin: release o=Debian
Pin-Priority: -10
EOF

echo "I: Mise à jour"
apt-get update
apt-get -y dist-upgrade
