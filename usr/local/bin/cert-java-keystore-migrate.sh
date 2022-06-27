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

# The JKS keystore uses a proprietary format. 
# It is recommended to migrate to PKCS12 which is an industry standard format using keytool

usage()
{
    echo "cert java migrate keystore format to specified format (PKCS12 is default))"
    echo "Usage: cert-java-keystore-migrate.sh <keystore filename> <new keystore filename> <store type>"
}

if [ "$1" = "" ] || [ "$2" = "" ]; then
    usage
    exit 1
fi

if [ "$4" = "" ]; then
    STORETYPE="PKCS12"
else
    STORETYPE="$4"
fi

keytool -importkeystore -srckeystore "$1" -destkeystore "$2" -deststoretype $STORETYPE

