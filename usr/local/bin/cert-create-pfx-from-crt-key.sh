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

# pfx = pkcs12

usage()
{
    echo "Create pfx from certificate and key"
    echo "Usage: cert-create-pfx-from-crt-key.sh <certificate filename> <key filename> <pfx filename> <alias (optional)>"
}

CERTFILENAME="$1"
KEYFILENAME="$2"
PFXFILENAME="$3"
ALIAS=""

if [ "$4" != "" ]; then
    ALIAS="$4"
fi

if [ "$CERTFILENAME" = "" ] || [ "$KEYFILENAME" = "" ] || [ "$PFXFILENAME" = "" ]; then
    usage
    exit 1
fi

#

if [ "$ALIAS" = "" ]; then
    openssl pkcs12 -export -out "$PFXFILENAME" -inkey "$KEYFILENAME" -in "$CERTFILENAME"
else
    openssl pkcs12 -export -out "$PFXFILENAME" -inkey "$KEYFILENAME" -in "$CERTFILENAME" -name "$ALIAS"
fi

