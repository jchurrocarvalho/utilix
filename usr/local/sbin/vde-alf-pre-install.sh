#!/bin/bash

#
# Released under MIT License
# Copyright (c) 2019-2022 Jose Manuel Churro Carvalho
# Permission is hereby granted, free of charge, to any person obtaining a copy of this software 
# and associated documentation files (the "Software"), to deal in the Software without restriction, 
# including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, 
# and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
# The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, 
# INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. 
# IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, 
# WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#

####
# change here to custom
####

# define instance name
INSTANCENAME=default

ACSVERSION=7.1-c
VDEVERSION=01.01
ASSVERSION=2.0

# postgres
PGSQLVERSION=13
# instance name for postgres can be the same as vde/alfresco, but no necessary.
# To test if it can be shared between vde/alfresco instances (why not?) 
PGSQLINSTANCENAME=default

# create structure
# base alfresco base installation dir
# define install base path, depending use as standalone, or integrated in VDE structure
# 7.1 right now it is the used version
# NOTES
# data like alf_data should be in a second disk, that's why below there is link alf_data to /var2/lib
# Moreover. To simplify create a /opt/vde in the second disk for instance /data2/opt/vde and before make 
# a symbolic link /opt/vde to /data2/opt/vde
#
# /var2 tipically is in a second disk like /data2/var2. Make a symbolic link /var2 to /data2/var2
#
ROOTINSTALLPATH=/opt/vde
VARROOTINSTALLPATH=/var2/lib/vde

####
#
####

#

sudo mkdir -p $ROOTINSTALLPATH
sudo mkdir -p $VARROOTINSTALLPATH

# /opt/vde/"name for instance (*1)"/acs-7.1-c
# (*1) for a agnostic instance should be "default"
# /opt/vde/$INSTANCENAME/acs-$ACSVERSION
ACSINSTALLBASEPATH=$ROOTINSTALLPATH/$INSTANCENAME/acs-$ACSVERSION
VARACSINSTALLBASEPATH=$VARROOTINSTALLPATH/$INSTANCENAME/acs-$ACSVERSION
ASSINSTALLBASEPATH=$ROOTINSTALLPATH/$INSTANCENAME/ass-$ASSVERSION
VARASSINSTALLBASEPATH=$VARROOTINSTALLPATH/$INSTANCENAME/ass-$ASSVERSION

sudo mkdir -p $ACSINSTALLBASEPATH
sudo mkdir -p $VARACSINSTALLBASEPATH
sudo mkdir -p $ASSINSTALLBASEPATH
sudo mkdir -p $VARASSINSTALLBASEPATH

# VDE
# /opt/vde/"name for instance (*1)"/vde/"version"
# (*1) for a agnostic instance should be "default" (ex: for 1.1 VDE version)
# /opt/vde/$INSTANCENAME/vde-$VDEVERSION
VDEINSTALLBASEPATH=$ROOTINSTALLPATH/$INSTANCENAME/vde-$VDEVERSION
VARVDEINSTALLBASEPATH=$VARROOTINSTALLPATH/$INSTANCENAME/vde-$VDEVERSION

sudo mkdir -p $VDEINSTALLBASEPATH
sudo mkdir -p $VARVDEINSTALLBASEPATH

# always create a symbolic link "latest" and "stable" to latest and stable version
sudo ln -s $ROOTINSTALLPATH/$INSTANCENAME/vde-$VDEVERSION $ROOTINSTALLPATH/$INSTANCENAME/vde-latest
sudo ln -s $ROOTINSTALLPATH/$INSTANCENAME/vde-$VDEVERSION $ROOTINSTALLPATH/$INSTANCENAME/vde-stable
sudo ln -s $VARROOTINSTALLPATH/$INSTANCENAME/vde-$VDEVERSION $VARROOTINSTALLPATH/$INSTANCENAME/vde-latest
sudo ln -s $VARROOTINSTALLPATH/$INSTANCENAME/vde-$VDEVERSION $VARROOTINSTALLPATH/$INSTANCENAME/vde-stable

sudo mkdir $VARACSINSTALLBASEPATH/alf_data
sudo ln -s $VARACSINSTALLBASEPATH/alf_data $ACSINSTALLBASEPATH/alf_data 

# for common components shared between instances
# /opt/vde/common
# /opt/vde/common/vde
# /opt/vde/common/alfresco
INSTALLCOMMONPATH=$ROOTINSTALLPATH/common
VARINSTALLCOMMONPATH=$VARROOTINSTALLPATH/common
VDEINSTALLCOMMONPATH=$INSTALLCOMMONPATH/vde
ACSINSTALLCOMMONPATH=$INSTALLCOMMONPATH/acs

sudo mkdir -p $INSTALLCOMMONPATH
sudo mkdir -p $VARINSTALLCOMMONPATH

# with version
VDEVERSIONINSTALLCOMMONPATH=$VDEINSTALLCOMMONPATH-$VDEVERSION
ACSVERSIONINSTALLCOMMONPATH=$ACSINSTALLCOMMONPATH-$ACSVERSION

sudo mkdir -p $VDEVERSIONINSTALLCOMMONPATH
sudo mkdir -p $ACSVERSIONINSTALLCOMMONPATH

# postgres
PGSQLVARPATH=$VARROOTINSTALLPATH/pgsql/$PGSQLVERSION
PGSQLVARINSTANCEPATH=$PGSQLVARPATH/$PGSQLINSTANCENAME

sudo mkdir -p $PGSQLVARINSTANCEPATH/data
sudo mkdir -p $PGSQLVARINSTANCEPATH/backups

# for conf, services, see "https://github.com/abhinavmishra14/alfresco7-solr-localtransform-dist-setup"
# structure and files can be also seen in "/home/public/downloads/alfresco/7.1/alfresco7-solr-localtransform-dist-setup".
# It is a base NOT FINAL VERSION. Useful to get or verify conf, services, properties and other stuff
# run ...

sudo mkdir -p $ACSINSTALLBASEPATH/bin
sudo mkdir -p $ACSINSTALLBASEPATH/amps
sudo mkdir -p $ACSINSTALLBASEPATH/amps_share
sudo mkdir -p $ACSINSTALLBASEPATH/licenses
sudo mkdir -p $ACSINSTALLBASEPATH/modules
sudo mkdir -p $ACSINSTALLBASEPATH/modules/platform
sudo mkdir -p $ACSINSTALLBASEPATH/modules/share
sudo mkdir -p $ACSINSTALLBASEPATH/alf_data/keystore
sudo mkdir -p $ACSINSTALLBASEPATH/tomcat
sudo mkdir -p $ACSINSTALLBASEPATH/tomcat/bin
sudo mkdir -p $ACSINSTALLBASEPATH/tomcat/conf
sudo mkdir -p $ACSINSTALLBASEPATH/tomcat/lib
sudo mkdir -p $ACSINSTALLBASEPATH/tomcat/shared
sudo mkdir -p $ACSINSTALLBASEPATH/tomcat/shared/classes
sudo mkdir -p $ACSINSTALLBASEPATH/tomcat/shared/lib
sudo mkdir -p $ACSINSTALLBASEPATH/tomcat/shared/classes/alfresco
sudo mkdir -p $ACSINSTALLBASEPATH/tomcat/shared/classes/alfresco/extension
sudo mkdir -p $ACSINSTALLBASEPATH/tomcat/shared/classes/alfresco/web-extension
sudo mkdir -p $ACSINSTALLBASEPATH/tomcat/shared/classes/alfresco/extension/keystore/metadata-keystore

# if common services should be dedicated to instance or ...
#sudo mkdir -p $ACSINSTALLBASEPATH/activemq
#sudo mkdir -p $ACSINSTALLBASEPATH/alfresco-pdf-renderer
#sudo mkdir -p $ACSINSTALLBASEPATH/exiftool
#sudo mkdir -p $ACSINSTALLBASEPATH/imagemagick
#sudo mkdir -p $ACSINSTALLBASEPATH/libreoffice

# ... or used and shared by multiple instances
sudo mkdir -p $ACSVERSIONINSTALLCOMMONPATH/bin
sudo mkdir -p $ACSVERSIONINSTALLCOMMONPATH/activemq
sudo mkdir -p $ACSVERSIONINSTALLCOMMONPATH/alfresco-pdf-renderer
sudo mkdir -p $ACSVERSIONINSTALLCOMMONPATH/exiftool
sudo mkdir -p $ACSVERSIONINSTALLCOMMONPATH/imagemagick
sudo mkdir -p $ACSVERSIONINSTALLCOMMONPATH/libreoffice
sudo mkdir -p $ACSVERSIONINSTALLCOMMONPATH/run
sudo mkdir -p $ACSVERSIONINSTALLCOMMONPATH/logs

# solr alfresco search services
sudo mkdir -p $ASSINSTALLBASEPATH/solrhome
sudo mkdir -p $ASSINSTALLBASEPATH/solrhome/conf
sudo mkdir -p $ASSINSTALLBASEPATH/solrhome/templates
sudo mkdir -p $ASSINSTALLBASEPATH/solrhome/templates/rerank
sudo mkdir -p $ASSINSTALLBASEPATH/solrhome/templates/rerank/conf

sudo chown -R alfresco:alfrescosys $ROOTINSTALLPATH/$INSTANCENAME/acs-$ACSVERSION
sudo chown -R alfresco:lfrescosys $VARROOTINSTALLPATH/$INSTANCENAME/acs-$ACSVERSION
sudo chown -R alfresco:lfrescosys $ACSVERSIONINSTALLCOMMONPATH
sudo chmod 775 $ROOTINSTALLPATH/$INSTANCENAME/acs-$ACSVERSION
sudo chmod 775 $VARROOTINSTALLPATH/$INSTANCENAME/acs-$ACSVERSION
sudo chmod 775 $ACSINSTALLBASEPATH/alf_data
sudo chmod 775 $VARACSINSTALLBASEPATH/alf_data

sudo chown -R solr:solrsys $ROOTINSTALLPATH/$INSTANCENAME/ass-$ASSVERSION
sudo chmod 775 $ROOTINSTALLPATH/$INSTANCENAME/ass-$ASSVERSION

mkdir -p $VARACSINSTALLBASEPATH/backup
mkdir -p $VARACSINSTALLBASEPATH/backup/ass
chown alfresco:alfrescosys $VARACSINSTALLBASEPATH/backup
chown solr:solrsys $VARACSINSTALLBASEPATH/backup/ass
chmod 775 $VARACSINSTALLBASEPATH/backup
chmod 775 $VARACSINSTALLBASEPATH/backup/ass

mkdir -p $VARACSINSTALLBASEPATH/alf_data/solr6Backup
chown alfresco:alfrescosys $VARACSINSTALLBASEPATH/alf_data/solr6Backup
chmod 775 $VARACSINSTALLBASEPATH/alf_data/solr6Backup

