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

usage()
{
    echo "bdsync usage to remote files"
    echo "Usage: bdsync-remote.sh <name> <username> <remote host> <filename only> <local path> <remote path>"
}

if [ "$1" = "" ] || [ "$2" = "" ] || [ "$3" = "" ] || [ "$4" = "" ] || [ "$5" = "" ] || [ "$6" = "" ]; then
    usage
    exit 1
fi

hostname=$(eval 'hostname')
DATE=$(date +%Y%m%d%H%M%S)

NAME="$1"

PATCHFILENAME=bdsync-patch-$NAME-$DATE.rsync

USERNAME="$2"
REMOTEHOST="$3"
FILENAMETOSYNC="$4"
LOCALPATH="$5"
REMOTEPATH="$6"

# find changes and create a compressed patch file
bdsync "ssh $USERNAME@$REMOTEHOST bdsync --server" "$LOCALPATH/$FILENAMETOSYNC" "$REMOTEPATH/$FILENAMETOSYNC" --diffsize=resize | gzip > "$LOCALPATH/$PATCHFILENAME"

# move patch file to remote host
rsync "$LOCALPATH/$PATCHFILENAME" $USERNAME@$REMOTEHOST:"$REMOTEPATH/$PATCHFILENAME"

# apply patch to remote file
(
    ssh -T $USERNAME@$REMOTEHOST  <<ENDSSH
    gzip -d < "$REMOTEPATH/$PATCHFILENAME" | bdsync --patch="$REMOTEPATH/$FILENAMETOSYNC" --diffsize=resize && echo "Done!"
    rm "$REMOTEPATH/$PATCHFILENAME"
ENDSSH
) | grep -q "Done!" && echo "Update successful" && rm "$LOCALPATH/$PATCHFILENAME"

# update remote file timestamp to match local file
MTIME=`stat "$LOCALPATH/$FILENAMETOSYNC" -c %Y`
ssh $USERNAME@$REMOTEHOST touch -c -d @"$MTIME" "$REMOTEPATH/$FILENAMETOSYNC" </dev/null

