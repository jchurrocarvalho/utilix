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

function convert()
{
	if !( test -d "$1" )
	then
		echo "$1";
		echo "Nothing todo here ..."
		return;
	fi

	cd "$1"
	echo "++++++++++++++++++++++++++++++++++++++++";
	echo $(pwd);

	# Directory
    for itd in *
    do
    	if ( test -d "$itd" )
        then  
        	convert "$itd"
        fi
    done

	# Files
	for itf in *.tif
	do
        #if ( test -x "$itf" )
	    if [ "$itf" != "*.tif" ];
		then
			echo "----------------------------------------"
			echo "Processing $itf"

			oldfilename="$itf"

			filename="${itf##*/}"                    			# Strip longest match of */ from start
			path="${itf:0:${#itf} - ${#filename}}" 				# Substring from 0 thru pos of filename
			filetitle="${filename%.[^.]*}"                     	# Strip shortest match of . plus at least one non-dot char from end
			ext="${filename:${#filetitle} + 1}"                 # Substring from len of base thru end
			if [[ -z "$filetitle" && -n "$ext" ]]; then         # If we have an extension and no base, it's really the base
				filetitle=".$ext"
				ext=""
			fi

			echo "$filename"
			echo "$path"
			echo "$filetitle"
			echo "$ext"

			newfilename="$filetitle.pdf"

			echo "Generating ... $newfilename"

		 	tiff2pdf "$oldfilename" -o "$newfilename"
		else
			echo "===>File: " "$itf" " = Error: unknown file."
		fi
	done

	cd ..
}

startdir=$(pwd)
echo "Starting ..."
echo "$startdir"
convert "$startdir"
cd "$startdir"

