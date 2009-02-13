#!/bin/sh -x

echo "###################"
echo "####### 03 ########"
echo "###################"
echo "I: install metasploit"

#mkdir /usr/share/framework-3.1
cd /usr/share/framework-3.1

# Téléchargement du paquet
#wget  http://sugar.metasploit.com/releases/framework-3.1.tar.gz
#tar xzf framework-3.1.tar.gz
#rm framework-3.1.tar.gz
#cd framework-3.1

# Création des liens symboliques
chmod +x msf*
cd /usr/local/bin
ln -s /usr/share/framework-3.1/msfcli
ln -s /usr/share/framework-3.1/msfconsole
ln -s /usr/share/framework-3.1/msfd
ln -s /usr/share/framework-3.1/msfencode
ln -s /usr/share/framework-3.1/msfgui
ln -s /usr/share/framework-3.1/msfopcode
ln -s /usr/share/framework-3.1/msfpayload
ln -s /usr/share/framework-3.1/msfpescan
ln -s /usr/share/framework-3.1/msfweb
