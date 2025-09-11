#!/bin/sh

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
    echo "nmap network scan with -v A -oA options"
    echo "Usage: nmap-net-a <network> <path filetitle (filename without extension)>"
}

if [ "$2" = "" ]; then
    usage
    exit 1
fi

NETWORK=$1
PATHFILETITLE=$2

# redirect stdin and stderr for PATHFILETITLE.txt
touch "$PATHFILETITLE".txt
exec 1>"$PATHFILETITLE".txt
exec 2>&1

nmap -v -A -oA  "$PATHFILETITLE" "$NETWORK"

echo ""
echo "================================"
echo "build html output"
echo "================================"
echo ""

xsltproc "$PATHFILETITLE".xml -o "$PATHFILETITLE".html

echo ""
echo "================================"
echo "end of build html output""
echo "================================"
echo ""

