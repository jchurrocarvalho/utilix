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

# pfx = pkcs12

usage()
{
    echo "cert/key convert/extract from pfx 2 several outputs"
    echo "Usage: cert-conv-pfx2.sh <pfx filename> <prefix file title (filename without extension)>"
}

if [ "$1" = "" ] || [ "$2" = "" ]; then
    usage
    exit 1
fi

PRIVATEKEY_ENC_PKEY_FILENAME="$2"-pkey.pem
PRIVATEKEY_NOENC_PKEY_FILENAME="$2"-noenc-key.pem
CERT_CLIENT_CERT_FILENAME="$2".crt
CERT_ALL_CERTS_FILENAME="$2"-certs.crt
CERT_CACERTS_FILENAME="$2"-cacerts.crt
CERT_CACERTS_CHAIN_FILENAME="$2"-cacerts-chain.crt
CERT_CACERTS_CHAIN_WITHOUTBAGATTRIBUTES_FILENAME="$2"-cacerts-chain-withoutbagattributes.crt
PRIVATEKEY_RSA_KEY_FILENAME="$2"-rsa.key
CERT_ENC_PKEY_CERT_FILENAME="$2"-pkey-cert.pem
CERT_NOENC_PKEY_CERT_FILENAME="$2"-noenc-key-cert.pem
CERT_ENC_PKEY_ALL_CERTS_FILENAME="$2"-pkey-certs.pem
CERT_NOENC_PKEY_ALL_CERTS_FILENAME="$2"-noenc-key-certs.pem
CERT_ENC_PKEY_ALL_CERTS_DER_FILENAME="$2"-pkey-certs.der

echo "Exporting only encrypted private key to $PRIVATEKEY_ENC_PKEY_FILENAME in pem format"
openssl pkcs12 -in "$1" -nocerts -out "$PRIVATEKEY_ENC_PKEY_FILENAME"
chmod go-rwx "$PRIVATEKEY_ENC_PKEY_FILENAME"

echo "Exporting only no encrypted private key to $PRIVATEKEY_NOENC_PKEY_FILENAME in pem format"
openssl pkcs12 -in "$1" -nocerts -out "$PRIVATEKEY_NOENC_PKEY_FILENAME" -nodes
chmod go-rwx "$PRIVATEKEY_NOENC_PKEY_FILENAME"

echo "Exporting only client certificate $CERT_CLIENT_CERT_FILENAME"
openssl pkcs12 -in "$1" -clcerts -nokeys -out "$CERT_CLIENT_CERT_FILENAME"
chmod go-rwx "$CERT_CLIENT_CERT_FILENAME"

echo "Exporting all certificates $CERT_ALL_CERTS_FILENAME"
openssl pkcs12 -in "$1" -nokeys -out "$CERT_ALL_CERTS_FILENAME"
chmod go-rwx "$CERT_ALL_CERTS_FILENAME"

echo "Exporting only CA certificates $CERT_CACERTS_FILENAME"
openssl pkcs12 -in "$1" -cacerts -nokeys -out "$CERT_CACERTS_FILENAME"
chmod go-rwx "$CERT_CACERTS_FILENAME"

echo "Exporting only CA certificates with chain $CERT_CACERTS_CHAIN_FILENAME"
openssl pkcs12 -in "$1" -cacerts -nokeys -chain -out "$CERT_CACERTS_CHAIN_FILENAME"
chmod go-rwx "$CERT_CACERTS_CHAIN_FILENAME"

echo "Exporting only CA certificates with chain without bag attributes $CERT_CACERTS_CHAIN_WITHOUTBAGATTRIBUTES_FILENAME"
openssl pkcs12 -in "$1" -cacerts -nokeys -chain | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' > "$CERT_CACERTS_CHAIN_WITHOUTBAGATTRIBUTES_FILENAME"
chmod go-rwx "$CERT_CACERTS_CHAIN_WITHOUTBAGATTRIBUTES_FILENAME"

echo "Exporting rsa key filename without passphrase or decrypted private key to $PRIVATEKEY_RSA_KEY_FILENAME"
openssl rsa -in "$PRIVATEKEY_NOENC_PKEY_FILENAME" -out "$PRIVATEKEY_RSA_KEY_FILENAME"
chmod go-rwx "$PRIVATEKEY_RSA_KEY_FILENAME"

echo "Exporting encrypted private key and cert combined to $CERT_ENC_PKEY_CERT_FILENAME in pem format"
openssl pkcs12 -in "$1" -out "$CERT_ENC_PKEY_CERT_FILENAME" -clcerts
chmod go-rwx "$CERT_ENC_PKEY_CERT_FILENAME"

echo "Exporting no encrypted private key and cert combined to $CERT_NOENC_PKEY_CERT_FILENAME in pem format"
openssl pkcs12 -in "$1" -out "$CERT_NOENC_PKEY_CERT_FILENAME" -clcerts -nodes
chmod go-rwx "$CERT_NOENC_PKEY_CERT_FILENAME"

echo "Exporting encrypted private key and all certs combined to $CERT_ENC_PKEY_ALL_CERTS_FILENAME in pem format"
openssl pkcs12 -in "$1" -out "$CERT_ENC_PKEY_ALL_CERTS_FILENAME"
chmod go-rwx "$CERT_ENC_PKEY_ALL_CERTS_FILENAME"

echo "Exporting no encrypted private key and all certs combined to $CERT_NOENC_PKEY_ALL_CERTS_FILENAME in pem format"
openssl pkcs12 -in "$1" -out "$CERT_NOENC_PKEY_ALL_CERTS_FILENAME" -nodes
chmod go-rwx "$CERT_NOENC_PKEY_ALL_CERTS_FILENAME"

echo "Exporting pem with encrypted key and all certs to der to use for example to import to java keystore, $CERT_ENC_PKEY_ALL_CERTS_DER_FILENAME"
openssl x509 -in "$CERT_ENC_PKEY_ALL_CERTS_FILENAME" -outform DER -out "$CERT_ENC_PKEY_ALL_CERTS_DER_FILENAME"
chmod go-rwx "$CERT_ENC_PKEY_ALL_CERTS_DER_FILENAME"

