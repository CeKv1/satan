#!/bin/sh
echo "###################"
echo "####### 02 ########"
echo "###################"

echo "I: Install hydra"

cd /usr/share/libssh-0.2
./configure
make
make install
cd ..
 
cd hydra-5.4-src
./configure
patch -p1 < ../hydra-libssh0.2.patch
 
# Correction d'un bug
sed -i 's/XDEFINES= -DLIBOPENSSL -DLIBPOSTGRES -DLIBSSH/XDEFINES= -DLIBOPENSSL -DLIBSSH/g' Makefile
sed -i 's/XLIBS= -lssl -lpq -lssh -lcrypto/XLIBS= -lssl -lssh -lcrypto/g' Makefile


make
make install

cd /usr/share/
rm -rf libssh-0.2
rm -rf hydra-5.4-src
rm -f hydra-libssh0.2.patch
