#!/bin/bash

# Execute when fastd is going up
# Autor: Thomas Arend
# (c) 2017 by Thomas Arend
# Date: 26.05.2018

INTERFACE=${1:-mesh-vpn}

# Start meshing on fastd tunnel
ip link set up dev $INTERFACE || echo Error: Interface $INTERFACE not set up

# Add tunnel interface to mesh
batctl if add $INTERFACE || echo Error: Interface $INTERFACE not added to batman
#sysctl net.ipv6.conf.bat0.disable_ipv6=1
#sysctl net.ipv6.conf.mesh-vpn.disable_ipv6=1

# Set mtu for bat0
# Change 1364 to your value in the site.conf for the FF firmware

ip link set up dev bat0 mtu 1364 || echo Error when setting MTU to 1364
batctl gw client 45
batctl orig_interval 5000
batctl multicast_mode 0
echo 15 > /sys/class/net/bat0/mesh/hop_penalty
echo 1 >  /sys/class/net/bat0/mesh/bridge_loop_avoidance
echo 1 >  /sys/class/net/$INTERFACE/batman_adv/no_rebroadcast

ip link add name br-client type bridge
ip link set bat0 master br-client

#  Add ipv6 addr with scope global to bat0

NIP='fda0:747e:ab29:2241'
GIP=`ip addr show dev br-client | grep 'inet6 fe80::.* scope link' | sed 's#.*inet6 fe80::##; s# .*$##'`

ip addr add ${NIP}:${GIP} dev br-client scope global || echo Error: IPv6 ${NIP}:${GIP} not set
