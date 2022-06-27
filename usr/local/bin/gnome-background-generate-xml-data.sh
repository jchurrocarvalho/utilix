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

#
# This script will take all wallpapers in $WALLPAPER_DIR and
# make them available as "default" background in the "Change Background" gui
# frontend in Ubuntu.
#
# Basically what it does is create an xml file in the
# /usr/share/gnome-background-properties directory which is read whenever a
# user logs into the system.
#
# All that should need changing to work in any other user's system is:
# WALLPAPER_DIR  (line 15)
# XML_FILE       (line 17)
################################################################################

NAME=002
WALLPAPER_DIR="/usr/local/share/backgrounds/$NAME"
CONFIG_DIR="/usr/local/share/gnome-background-properties"
XML_FILE="$CONFIG_DIR/$NAME-wallpapers.xml"

#### First check if we have write permissions to the share dirctory. ####
touch $CONFIG_DIR/testfile >/dev/null 2>/dev/null
if [[ $? -ne 0 ]]; then
   echo "**** No permissions to the desktop share directory. ****"
   echo "**** $CONFIG_DIR ****"
   echo "**** Procedure Terminated. ****"
   exit 1
else
   rm $CONFIG_DIR/testfile 2>/dev/null
fi

#### Show the script description message. ###
cat <<EOF

################################################################################
     This script makes all pictures in the $WALLPAPER_DIR
     directory available to all users defined on this system as their
     system-wide GNOME wallpapers.

     This script should be run as "root" or with "sudo".
     e.g. sudo $0
################################################################################
EOF

#### Fail if the wallpaper directory does not exist. ####
if [[ ! -d $WALLPAPER_DIR ]]; then
    echo "**** The wallpaper directory \"$WALLPAPER_DIR\" does not exist. ****"
    echo "**** Precedure Terminated. ****"
    exit 1
fi

#### Count the number of jpg/jpeg/png images. ####
numfiles=`ls -1 $WALLPAPER_DIR/*.jpg WALLPAPER_DIR/*.jpeg WALLPAPER_DIR/*.png 2>/dev/null | wc -l`

#### If there are no image files there then exit. ####
if [[ $numfiles -eq 0 ]]; then
    echo "**** The wallpaper directory \"$WALLPAPER_DIR\" has no images. ****"
    echo "**** Precedure Terminated. ****"
    exit 1
fi

#### Now we create the XML file containing the images for backgrounds. ####
#### Start by creating the header in the XML file. ####
cat <<EOF > $XML_FILE
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE wallpapers SYSTEM "gnome-wp-list.dtd">
<wallpapers>
EOF

#### Add each file to the XML file. ####
#### Doing it this way makes sure files with spaces in their names are ####
#### handled properly.   (ls .... | while read fname; do)              ####
ls -1 $WALLPAPER_DIR/*.jpg $WALLPAPER_DIR/*.png $WALLPAPER_DIR/*.jpeg 2> /dev/null |
while read image_name; do
   echo "   Adding: `basename "$image_name"`."
   fname=`basename "$image_name"`
   fname="${fname%%\.*}"
   echo "  <wallpaper>"                          >> $XML_FILE
   echo "    <name>$fname</name>"                >> $XML_FILE
   echo "    <filename>$image_name</filename>"   >> $XML_FILE
   echo "    <options>stretched</options>"       >> $XML_FILE
   echo "    <pcolor>#c58357</pcolor>"           >> $XML_FILE
   echo "    <scolor>#c58357</scolor>"           >> $XML_FILE
   echo "    <shade_type>solid</shade_type>"     >> $XML_FILE
   echo "  </wallpaper>"                         >> $XML_FILE
done

#### Create the footer for the XML file. ####
echo "</wallpapers>"                             >> $XML_FILE

#### Lastly display a message to inform caller to logout and back in. ####
cat <<EOF
################################################################################
     You're almost done. Log out and back in. Invoke the Desktop Background
     Change application again, and all your selected wallpapers should be
     available to use for all users.
################################################################################

