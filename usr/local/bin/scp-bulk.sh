#!/bin/sh

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
    echo "scp to list machines"
    echo "Usage: scp-bulk.sh <user> <host file list> <dest> <files to copy>"
}

if [ "$1" = "" ] || [ "$2" = "" ] || [ "$3" = "" ] || [ "$4" = "" ]; then
    usage
    exit 1
fi

hostname=$(eval 'hostname')

files_args=""

i=0

for arg in "$@"
do
    if [ $i -ge 3 ]; then
        if [ "$files_args" != "" ]; then
            files_args+=" "
        fi
        files_args+="$arg"
    fi
    i=$((i+1))
done

for line in $(cat "$2"); do
    if [ ! -z "$line" ]; then
        if [ "$hostname" != "$line" ]; then
            echo "================================================================"
            echo "host: $line"
            echo "================================================================"
            echo ""
            #scp "$4" "$1@$line:$3"
            #scp -r "$files_args" "$1@$line:$3"
            i=0
            for arg in "$@"
            do
                if [ $i -ge 3 ]; then
                    scp "$arg" "$1@$line:$3"
                fi
                i=$((i+1))
            done
            echo ""
        fi
    fi
done

exit 0

