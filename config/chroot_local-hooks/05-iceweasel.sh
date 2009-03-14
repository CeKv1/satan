#!/bin/sh
echo "###################"
echo "####### 05 ########"
echo "###################"
sed -i 's/about:/file:\/\/\/usr\/share\/doc\/satan-manual\/html\/index.html/g' /usr/lib/iceweasel/browserconfig.properties
#echo "pref(\"browser.startup.homepage\", \"/usr/share/doc/satan-manual/html/index.html\");" >> /etc/iceweasel/pref/iceweasel.js
