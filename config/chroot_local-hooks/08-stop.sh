#!/bin/sh -x

echo "###################"
echo "####### 08 ########"
echo "###################"

ARRAY=( 'mysql' 'apache2' 'bind9' 'puppet' 'puppetmaster' 'ssh' 'pimd' 'samba' 'freeradius' 'squid' 'snmpd' 'quagga' 'ipsec' 'snort' 'asterisk' 'slapd' 'munin-node')
ELEMENTS=${#ARRAY[@]}
for (( i=0;i<$ELEMENTS;i++))
do
	echo "I: ${ARRAY[${i}]}"
	update-rc.d  -f ${ARRAY[${i}]} remove
	update-rc.d  ${ARRAY[${i}]} stop  0 1 2 3 4 5 6 .
done	
# Démarrage
update-rc.d -f satan defaults 99
