#!/bin/bash

#
# Copyright (c) 2019-2022 Jose Manuel Churro Carvalho
#

brctl addbr br0
brctl addif br0 enp5s0
ip addr add dev br0 105.0.0.212/24
ip route add default via 105.0.0.254 dev br0

