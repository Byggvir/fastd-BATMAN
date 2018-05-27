#!/bin/bash

# Installation B.A.T.M.A.N.
# Version festlegen

VBAT="2018.1"
SRC="https://downloads.open-mesh.org/batman/releases/batman-adv-${VBAT}"

# Installation der linux-headers für den Kernel.

MACHINE=$(uname -m)

case "$MACHINE" in

 x86_64) 
    apt install linux-headers-amd64 	# Debian
    ;;
 armv7l)
    apt install raspberrypi-kernel-headers  # Raspian
    ;;
 *)
 echo -e "Unbekannte Architektur ${MACHINE}"
 exit 1
 ;;
 
esac

# Wir brauchen ein paar Repos, die nicht im Default einhalten sind.

grep 'http://repo.universe-factory.net/debian/' /etc/apt/sources.list || echo  'deb http://repo.universe-factory.net/debian/ sid main' >> /etc/apt/sources.list

# Und den Schlüssel für das Paket. Aktuell: 16EF3F64CB201D9C

KEY=16EF3F64CB201D9C
gpg --keyserver pgpkeys.mit.edu --recv-key $KEY
gpg -a --export $KEY | apt-key add -

# Nun die Software, die wahrscheinlich fehlt, inklusive fastd

apt install apt-transport-https
apt update
apt install build-essential bridge-utils pkg-config libnl-3-dev libnl-genl-3-dev fastd

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

# Wir können batman-adv gleich starten

modprobe batman-adv

# ... und in die /etc/modules eintragen, damit es auch bei einem Neustart vorhanden ist

grep '^batman-adv' /etc/modules || echo -e '#B.A.T.M.A.N für Freifunk\nbatman-adv' >> /etc/modules

# zum Schluss legen wir uns noch ein Verzeichnis für die Konfiguration der fastd-Tunnel an.

mkdir -p /etc/fastd/ffrhb/peers
