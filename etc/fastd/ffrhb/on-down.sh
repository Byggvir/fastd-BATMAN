#!/bin/bash

# Execute when fastd is going down
# Autor: Thomas Arend
# (c) 2018 by Thomas Arend
# Date: 27.05.2018

ip link delete br-client type bridge
ip link set down dev bat0
ip link delete dev bat0
