#!/bin/sh -x

echo "###################"
echo "####### 07 ########"
echo "###################"
mkdir /home/etu/
mkdir /home/etu/Desktop/

echo "I: Création des liens dans le bureau"

cat << EOF >> /home/etu/Desktop/services.sh
#!/bin/sh -x
/etc/init.d/$1 $2
EOF

chmod +x /home/etu/Desktop/services.sh
#chown etu:etu /home/etu/Desktop/services.sh
