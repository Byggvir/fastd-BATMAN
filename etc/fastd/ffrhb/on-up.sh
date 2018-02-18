#!/bin/bash

# Execute when fastd is up
# Autor: Thomas Arend
# (c) 2017 by Thomas Arend
# Date: 03.03.2017

INTERFACE=${1:-mesh-vpn}

# Start meshing on fastd tunnel
ip link set up dev $INTERFACE || echo Error: Interface $INTERFACE not set up

# Add tunnel interface to mesh
batctl if add $INTERFACE || echo Error: Interface $INTERFACE not added to batman

# Set mtu for bat0
# Change 1364 to your value in the site.conf for the FF firmware

ip link set up dev bat0 mtu 1364 || echo Error when setting MTU to 1364

#  Add ipv6 addr with scope global to bat0

NIP='fda0:747e:ab29:2241'
GIP=`ip addr show dev bat0 | grep 'inet6 fe80::.* scope link' | sed 's#.*inet6 fe80::##; s# .*$##'`

ip addr add ${NIP}:${GIP} dev bat0 scope global || echo Error: IPv6 ${NIP}:${GIP} not set
