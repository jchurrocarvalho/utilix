#!/bin/bash

#
# Copyright (c) 2019-2022 Jose Manuel Churro Carvalho
#

#nmcli connection add type bridge con-name bridge-br0 ifname br0
nmcli connection add type bridge con-name br0 ifname br0

# STP no
#nmcli connection modify bridge-br0 bridge.stp no
nmcli connection modify br0 bridge.stp no

#
#nmcli connection add type bridge-slave ifname enp5s0 master bridge-br0
nmcli connection add type bridge-slave ifname enp5s0 master br0

# ip address
#nmcli connection modify bridge-br0 ipv4.method manual ipv4.addresses 105.0.0.212/24
nmcli connection modify br0 ipv4.method manual ipv4.addresses 105.0.0.212/24

# gateway, dns
#nmcli connection modify bridge-br0 ipv4.gateway 105.0.0.254
nmcli connection modify br0 ipv4.gateway 105.0.0.254
nmcli connection modify br0 ipv4.dns "105.0.0.213 105.0.0.6 105.0.0.232"
nmcli connection modify br0 ipv4.dns-search "info.papiro.pt papiro.pt sogenave.pt"

#
#nmcli connection modify bridge-br0 autoconnect yes
#nmcli connection modify br0 autoconnect yes

