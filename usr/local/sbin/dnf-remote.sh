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
    echo "dnf remote"
    echo "Usage: dnf-remote.sh <user> <host> <... dnf options ...>"
}

if [ "$1" = "" ] || [ "$2" = "" ]; then
    usage
    exit 1
fi

hostname=$(eval 'hostname')

user="$1"
host_to_dnf="$2"
dnf_args=""

i=0

for arg in "$@"
do
    if [ $i -ge 2 ]; then
        if [ "$dnf_args" != "" ]; then
            dnf_args+=" "
        fi
        dnf_args+="$arg"
    fi
    i=$((i+1))
done

echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo "host: $host_to_dnf"
echo "Using dnf options: $dnf_args"
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo ""

ssh $user@$host_to_dnf bash -c "\"dnf $dnf_args\""

exit 0

