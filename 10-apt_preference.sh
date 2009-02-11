#/bin/sh -x

echo "I: Mise à jour des sources"

cat <<EOF > /etc/apt/sources.list
deb http://localhost:9999/debian lenny main contrib non-free
deb http://localhost:9999/security lenny/updates main contrib non-free

# Local packages
deb file:/root/local-packages ./
EOF

echo "I: Mise à jour des préférences"

rm -f /etc/apt/preferences

apt-get update
