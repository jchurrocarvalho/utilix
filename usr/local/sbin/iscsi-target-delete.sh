#!/bin/bash

#
# Copyright (c) 2019-2022 Jose Manuel Churro Carvalho
#

#logout session
iscsiadm --mode node --targetname iqn.1995-05.com.seagate:pap-nas-01.iscsi5 --portal 105.0.0.220:3260 --logout
iscsiadm --mode node --targetname iqn.1992-05.com.lacie:pap-nas-01:iscsi3 --portal 105.0.0.220:3260 --logout
iscsiadm --mode node --targetname iqn.1992-05.com.lacie:pap-nas-01:iscsi3 --portal 192.168.220.1:3260 --logout

iscsiadm --mode node -o delete --targetname iqn.1992-05.com.lacie:pap-nas-01:iscsi3 --portal 105.0.0.220:3260
iscsiadm --mode node -o delete --targetname iqn.1992-05.com.lacie:pap-nas-01:iscsi3 --portal 192.168.220.1:3260
iscsiadm --mode node -o delete --targetname iqn.1995-05.com.seagate:pap-nas-01:iscsi5 --portal 105.0.0.220:3260

iscsiadm --mode discoverydb --type sendtargets --portal 105.0.0.220:3260 -o delete

