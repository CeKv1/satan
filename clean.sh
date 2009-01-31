#!/bin/sh

# Répertoire de travail
SH_BASE="${SH_BASE:-`pwd`}"

#Scripts de live-helper
. "${LH_BASE:-/usr/share/live-helper}"/functions.sh

lh_clean --all

rm -f build.log
rm -rf cache .stage
