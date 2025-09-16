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
    echo "set recursive default acl group according to base group perms (several groups)"
	echo "Usage: setacls-def-g-r.sh <path> <group> ..."
}

if [ "$2" = "" ]; then
    usage
    exit 1
fi

#
acl_args=""
i=0

for arg in "$@"; do
    if [ $i -ge 1 ]; then
        if [ "$acl_args" != "" ]; then
            acl_args+=","
        fi
        acl_args+="g:$arg:rwx"
    fi
    i=$((i+1));
done

find -P "$1" -type d -perm -g=rwx -exec setfacl -dm $acl_args {} \;

#
acl_args=""
i=0

for arg in "$@"; do
    if [ $i -ge 1 ]; then
        if [ "$acl_args" != "" ]; then
            acl_args+=","
        fi
        acl_args+="g:$arg:rx"
    fi
    i=$((i+1));
done

find -P "$1" -type d -perm -g=rx ! -perm /g=w -exec setfacl -dm $acl_args {} \;

#
acl_args=""
i=0

for arg in "$@"; do
    if [ $i -ge 1 ]; then
        if [ "$acl_args" != "" ]; then
            acl_args+=","
        fi
        acl_args+="g:$arg:000"
    fi
    i=$((i+1));
done

find -P "$1" -type d ! -perm /g=r ! -perm /g=w ! -perm /g=x -exec setfacl -dm $acl_args {} \;

exit 0

