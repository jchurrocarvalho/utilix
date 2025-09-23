#!/bin/bash

#
# Released under MIT License
# Copyright (c) 2018-2025 Jose Manuel Churro Carvalho
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
    echo "set recursive acl group according to base group perms (several groups)"
    echo "if user/group is EMPTY or 0, the acl is set for no named user/group"
    echo "Usage: setacls-g-r.sh <recalculate mask? (0/1)> <path> <group> ..."
}

if [ "$3" = "" ]; then
    usage
    exit 1
fi

if [ "$1" = "1" ]; then
    RECALCULATEMASKOPTION=""
else
    RECALCULATEMASKOPTION="-n"
fi

BASEPATH="$2"

#
acl_args=""
i=0

for arg in "$@"; do
    if [ $i -ge 2 ]; then
        if [ "$acl_args" != "" ]; then
            acl_args+=","
        fi
        if [ "$arg" = "EMPTY" ] || [ "$arg" = "0" ]; then
            GROUPID=""
        else
            GROUPID="$arg"
        fi
        acl_args+="g:$GROUPID:rwx"
    fi
    i=$((i+1))
done

find -P "$BASEPATH" ! -type l -perm -g=rwx -exec setfacl "$RECALCULATEMASKOPTION" -m "$acl_args" {} \;

#
acl_args=""
i=0

for arg in "$@"; do
    if [ $i -ge 2 ]; then
        if [ "$acl_args" != "" ]; then
            acl_args+=","
        fi
        if [ "$arg" = "EMPTY" ] || [ "$arg" = "0" ]; then
            GROUPID=""
        else
            GROUPID="$arg"
        fi
        acl_args+="g:$GROUPID:rx"
    fi
    i=$((i+1))
done

find -P "$BASEPATH" ! -type l -perm -g=rx ! -perm /g=w -exec setfacl "$RECALCULATEMASKOPTION" -m "$acl_args" {} \;

#
acl_args=""
i=0

for arg in "$@"; do
    if [ $i -ge 2 ]; then
        if [ "$acl_args" != "" ]; then
            acl_args+=","
        fi
        if [ "$arg" = "EMPTY" ] || [ "$arg" = "0" ]; then
            GROUPID=""
        else
            GROUPID="$arg"
        fi
        acl_args+="g:$GROUPID:rw"
    fi
    i=$((i+1))
done

find -P "$BASEPATH" -type f -perm -g=rw ! -perm /g=x -exec setfacl "$RECALCULATEMASKOPTION" -m "$acl_args" {} \;

#
acl_args=""
i=0

for arg in "$@"; do
    if [ $i -ge 2 ]; then
        if [ "$acl_args" != "" ]; then
            acl_args+=","
        fi
        if [ "$arg" = "EMPTY" ] || [ "$arg" = "0" ]; then
            GROUPID=""
        else
            GROUPID="$arg"
        fi
        acl_args+="g:$GROUPID:r"
    fi
    i=$((i+1))
done

find -P "$BASEPATH" -type f -perm -g=r ! -perm /g=w ! -perm /g=x -exec setfacl "$RECALCULATEMASKOPTION" -m "$acl_args" {} \;

#
acl_args=""
i=0

for arg in "$@"; do
    if [ $i -ge 2 ]; then
        if [ "$acl_args" != "" ]; then
            acl_args+=","
        fi
        if [ "$arg" = "EMPTY" ] || [ "$arg" = "0" ]; then
            GROUPID=""
        else
            GROUPID="$arg"
        fi
        acl_args+="g:$GROUPID:000"
    fi
    i=$((i+1))
done

find -P "$BASEPATH" -type d ! -perm /g=r ! -perm /g=w ! -perm /g=x -exec setfacl "$RECALCULATEMASKOPTION" -m "$acl_args" {} \;

exit 0

