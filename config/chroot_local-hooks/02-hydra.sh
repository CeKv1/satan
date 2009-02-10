#!/bin/sh
echo "I: Install hydra"

mkdir /tmp/hydra
cd /tmp/hydra

##############
# libssh
############## 
# Téléchargement de l'archive
wget http://0xbadc0de.be/libssh/libssh-0.2.tgz
 
# Décompression
tar xzf libssh-0.2.tgz
cd libssh-0.2
./configure
make
make install
cd ..
 
############## 
# hydra
############## 

# Téléchargement de l'archive
wget http://freeworld.thc.org/releases/hydra-5.4-src.tar.gz
 
# Décompression 
tar xzf hydra-5.4-src.tar.gz
 
# Téléchargement du patch
wget http://0xbadc0de.be/libssh/hydra-libssh0.2.patch
 
cd hydra-5.4-src
./configure
patch -p1 < ../hydra-libssh0.2.patch
 
# Correction d'un bug
sed -i 's/XDEFINES= -DLIBOPENSSL -DLIBPOSTGRES -DLIBSSH/XDEFINES= -DLIBOPENSSL -DLIBSSH/g' Makefile
sed -i 's/XLIBS= -lssl -lpq -lssh -lcrypto/XLIBS= -lssl -lssh -lcrypto/g' Makefile
 
make
make install

# Nettoyage
cd /tmp/
rm -rf hydra
