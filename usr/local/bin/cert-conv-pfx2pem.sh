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

# pfx = pkcs12

usage()
{
    echo "cert/key convert from pfx 2 pem"
    echo "Usage: cert-conv-pfx2pem.sh <pfx filename> <pem no encrypted private key filename> <client cert filename> <certs filename>"
    echo "                            <ca certs filename> <rsa no passphrase key filename> <encrypted private key filename and all certs>"
}

if [ "$7" = "" ]; then
    usage
    exit 1
fi

echo "Exporting no encrypted private key to $2"
openssl pkcs12 -in "$1" -nocerts -out "$2" -noenc

echo "Exporting client certificate to $3"
openssl pkcs12 -in "$1" -clcerts -nokeys -out "$3"

echo "Exporting certificates to $4"
openssl pkcs12 -in "$1" -nokeys -out "$4"

echo "Exporting ca certificates to $5"
openssl pkcs12 -in "$1" -cacerts -nokeys -out "$5"

echo "Exporting rsa key filename without passphrase to $6"
openssl rsa -in "$2" -out "$6"

echo "Exporting encrypted private key and all certs to $7"
openssl pkcs12 -in "$1" -out "$7"

