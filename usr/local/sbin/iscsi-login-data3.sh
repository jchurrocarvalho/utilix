#!/bin/bash

#
# Copyright (c) 2019-2022 Jose Manuel Churro Carvalho
#

iscsiadm --mode node --targetname iqn.1995-05.com.seagate:pap-nas-01.iscsi5 --portal 192.168.220.1:3260 --login

