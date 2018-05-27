#!/bin/bash

# Installation B.A.T.M.A.N.
# Version festlegen

VBAT="2018.1"

apt update
apt upgrade


# Jetzt wird B.A.T.M.A.N. batctl aus den Quellen geladen und installiert

cd /usr/src/
wget http://downloads.open-mesh.org/batman/stable/sources/batctl/batctl-${VBAT}.tar.gz
tar xzf batctl-${VBAT}.tar.gz
cd batctl-${VBAT}
make
make install


# Jetzt wird B.A.T.M.A.N. batman-adv aus den Quellen geladen und installiert

cd /usr/src/
wget http://downloads.open-mesh.org/batman/stable/sources/batman-adv/batman-adv-${VBAT}.tar.gz
tar xzf batman-adv-${VBAT}.tar.gz
cd batman-adv-${VBAT}
make
make install

systemctl stop fastd
rmmod batman-adv
modprobe batman-adv
systemctl start fastd
