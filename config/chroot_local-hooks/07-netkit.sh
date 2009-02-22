#!/bin/sh -x

echo "###################"
echo "####### 07 ########"
echo "###################"

cd /usr/share/netkit
export NETKIT_HOME=/usr/share/netkit
export MANPATH=:$NETKIT_HOME/man
export PATH=$NETKIT_HOME/bin:$PATH

./check_configuration.sh

echo "I: VisualNetkit"
cd /usr/share/visualnetkit-1.4
sed -i 's/.\/visualnetkit.sh//g' build.sh
./build.sh  
