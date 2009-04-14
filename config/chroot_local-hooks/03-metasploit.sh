#!/bin/sh

echo "###################"
echo "####### 03 ########"
echo "###################"
echo "I: install metasploit"

cd /usr/share/framework-3.2

chmod +x msf*
cd /usr/local/bin
ln -s /usr/share/framework-3.2/msfcli
ln -s /usr/share/framework-3.2/msfconsole
ln -s /usr/share/framework-3.2/msfd
ln -s /usr/share/framework-3.2/msfencode
ln -s /usr/share/framework-3.2/msfgui
ln -s /usr/share/framework-3.2/msfopcode
ln -s /usr/share/framework-3.2/msfpayload
ln -s /usr/share/framework-3.2/msfpescan
ln -s /usr/share/framework-3.2/msfweb
