#!/bin/bash

# Installation B.A.T.M.A.N.
# Version festlegen

VBAT="2018.1"
SRC="https://downloads.open-mesh.org/batman/releases/batman-adv-${VBAT}"

apt update
apt upgrade

# Jetzt wird B.A.T.M.A.N. alfred aus den Quellen geladen und installiert

cd /tmp
wget ${SRC}/alfred-${VBAT}.tar.gz
tar xzf alfred-${VBAT}.tar.gz
cd alfred-${VBAT}
make CONFIG_ALFRED_GPSD=n
make CONFIG_ALFRED_GPSD=n install

# Jetzt wird B.A.T.M.A.N. batctl aus den Quellen geladen und installiert

cd /tmp
wget ${SRC}/batctl-${VBAT}.tar.gz
tar xzf batctl-${VBAT}.tar.gz
cd batctl-${VBAT}
make
make install


# Jetzt wird B.A.T.M.A.N. batman-adv aus den Quellen geladen und installiert

cd /tmp
wget ${SRC}/batman-adv-${VBAT}.tar.gz
tar xzf batman-adv-${VBAT}.tar.gz
cd batman-adv-${VBAT}
make
make install
