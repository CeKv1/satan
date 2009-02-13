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
update-rc.d  -f ssh remove
update-rc.d  ssh stop  0 1 2 3 4 5 6 .
update-rc.d  -f pimd remove
update-rc.d  pimd stop  0 1 2 3 4 5 6 .
update-rc.d  -f samba remove
update-rc.d  samba stop  0 1 2 3 4 5 6 .
update-rc.d  -f freeradius remove
update-rc.d  freeradius stop  0 1 2 3 4 5 6 .
update-rc.d  -f squid remove
update-rc.d  squid stop  0 1 2 3 4 5 6 .
update-rc.d  -f snmpd remove
update-rc.d  snmpd stop  0 1 2 3 4 5 6 .
update-rc.d  -f quagga remove
update-rc.d  quagga stop  0 1 2 3 4 5 6 .
