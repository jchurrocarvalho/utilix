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
    echo "postgres restore database"
    echo "Usage: pgsql-restore-db.sh <database name> <database username> <server> <port> <dump filename with gz> <create role?> <password>"
}

if [ "$6" = "" ]; then
    usage
    exit 1
fi

DBNAME="$1"
DBUSERNAME="$2"
SERVERNAME="$3"
PORT="$4"
DUMPFILENAME="$5"
CREATEROLE="$6"
DBUSERPASSWORD="$7"

if [ "$CREATEROLE" = "1" ]; then
    if [ "$DBUSERPASSWORD" = "" ]; then
        usage
        exit 1
    fi
fi

sudo -u postgres psql postgres -p "$PORT" -c "drop database if exists $DBNAME;"

if [ "$CREATEROLE" = "1" ]; then
    sudo -u postgres psql postgres -p "$PORT" -c "create role $DBUSERNAME LOGIN password '$DBUSERPASSWORD';";
fi

sudo -u postgres psql postgres -p "$PORT" -c "create database $DBNAME with template 'template0' encoding 'UTF8';"
sudo -u postgres psql postgres -p "$PORT" -c "grant all on database $DBNAME to $DBUSERNAME;"

gunzip -c "$DUMPFILENAME" | pg_restore -U "$DBUSERNAME" -h "$SERVERNAME" -p "$PORT" --clean --no-privileges --no-owner --data-only -d "$DBNAME"

