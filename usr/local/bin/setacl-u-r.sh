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
    echo "set acl user recursive"
    echo "Usage: setacl-u-r <path> <username>"
}

if [ "$1" = "" ] || [ "$2" = "" ]; then
    usage
    exit 1
fi

find "$1" -type f -perm -u=rwx -exec setfacl -m u:$2:rwx {} \;
find "$1" -type f -perm -u=rx ! -perm -u=w -exec setfacl -m u:$2:rx {} \;
find "$1" -type f -perm -u=rw ! -perm -u=x -exec setfacl -m u:$2:rw {} \;
find "$1" -type f -perm -u=r ! -perm /u=wx -exec setfacl -m u:$2:r {} \;
find "$1" -type d -perm -u=rwx -exec setfacl -m u:$2:rwx {} \;
find "$1" -type d -perm -u=rx ! -perm -u=w -exec setfacl -m u:$2:rx {} \;

exit 0

