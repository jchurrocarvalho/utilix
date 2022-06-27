#!/bin/bash

#
# Copyright (c) 2019-2022 Jose Manuel Churro Carvalho
#

DATE=$(date +%Y%m%d%H%M%S)
HOSTNAME=papiro-jcarvalho2
BACKUPPATH=/media/HDX_BAK_4_r/localbackup

tar -cvzf $BACKUPPATH/rotated/hosts/$HOSTNAME/home-bin-$DATE.tar.gz /home/bin
tar -cvzf $BACKUPPATH/rotated/hosts/$HOSTNAME/home-sbin-$DATE.tar.gz /home/sbin
tar -cvzf $BACKUPPATH/rotated/hosts/$HOSTNAME/etc-$DATE.tar.gz /etc
tar --ignore-failed-read -cvzf $BACKUPPATH/rotated/hosts/$HOSTNAME/home-jose-churro-local-$DATE.tar.gz /home/jose-churro-local
tar --ignore-failed-read -cvzf $BACKUPPATH/rotated/hosts/$HOSTNAME/home-ubuuser-$DATE.tar.gz /home/ubuuser
tar -cvzf $BACKUPPATH/rotated/hosts/$HOSTNAME/home-private-$DATE.tar.gz /home/private
tar -cvzf $BACKUPPATH/rotated/hosts/$HOSTNAME/home-share-$DATE.tar.gz /home/share
tar -cvzf $BACKUPPATH/rotated/hosts/$HOSTNAME/usr-local-bin-$DATE.tar.gz /usr/local/bin
tar -cvzf $BACKUPPATH/rotated/hosts/$HOSTNAME/usr-local-sbin-$DATE.tar.gz /usr/local/sbin

tar -cvzf $BACKUPPATH/rotated/hosts/$HOSTNAME/usr-share-applications-$DATE.tar.gz /usr/share/applications
tar -cvzf $BACKUPPATH/rotated/hosts/$HOSTNAME/usr-share-desktop-directories-$DATE.tar.gz /usr/share/desktop-directories
tar -cvzf $BACKUPPATH/rotated/hosts/$HOSTNAME/usr-share-backgrounds-$DATE.tar.gz /usr/share/backgrounds
tar -cvzf $BACKUPPATH/rotated/hosts/$HOSTNAME/usr-share-themes-$DATE.tar.gz /usr/share/themes

