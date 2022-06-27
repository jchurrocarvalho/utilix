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
    echo "dbsync file to remote host"
    echo "Usage: dbsync-file-remote.sh <user> <remote host> <local filename> <remote filename> <patch tmp filename>"
}

if [ "$1" = "" ] || [ "$2" = "" ] || [ "$3" = "" ] || [ "$4" = "" ] || [ "$5" = "" ]; then
    usage
    exit 1
fi

hostname=$(eval 'hostname')

USERNAME="$1"
REMOTE_HOST="$2"
LOCAL_FILE="$3"
REMOTE_FILE="$4"
PATCH="$5"
LOCAL_TMPDIR=/tmp/
REMOTE_TMPDIR=/tmp/

# find changes and create a compressed patch file
bdsync "ssh $USERNAME@$REMOTE_HOST bdsync --server" "$LOCAL_FILE" "$REMOTE_FILE" --diffsize=resize | pigz > "$LOCAL_TMPDIR/$PATCH"

# move patch file to remote host
rsync "$LOCAL_TMPDIR/$PATCH" $REMOTE_HOST:$REMOTE_TMPDIR/$PATCH

# apply patch to remote file
(
    ssh -T $USERNAME@$REMOTE_HOST  <<ENDSSH
    pigz -d < $REMOTE_TMPDIR/$PATCH | bdsync --patch="$REMOTE_FILE" --diffsize=resize && echo "ALL-DONE"
    rm $REMOTE_TMPDIR/$PATCH
ENDSSH
) | grep -q "ALL-DONE" && echo "Update succesful"  && rm "$LOCAL_TMPDIR/$PATCH"

# (optional) update remote file timestamp to match local file
MTIME=`stat "$LOCAL_$FILE" -c %Y`
ssh $USERNAME@$REMOTE_HOST touch -c -d @"$MTIME_0" "$REMOTE_FILE" </dev/null

