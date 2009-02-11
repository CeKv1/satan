#!/bin/sh -x

echo "###################"
echo "####### 08 ########"
echo "###################"
update-rc.d  -f mysql remove
update-rc.d  mysql stop  0 1 2 3 4 5 6 .
update-rc.d  -f apache2 remove
update-rc.d  apache2 stop  0 1 2 3 4 5 6 .
update-rc.d  -f bind9 remove
update-rc.d  bind9 stop  0 1 2 3 4 5 6 .
update-rc.d  -f puppet remove
update-rc.d  puppet stop  0 1 2 3 4 5 6 .
update-rc.d  -f puppetmaster remove
update-rc.d  puppetmaster stop  0 1 2 3 4 5 6 .
