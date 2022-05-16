#!/usr/bin/env bash

###################################################
#
# Created at: 27/03/2022 18:25
# Author: Raphael Henrique
#
# Description: simple script to download "bing.com"
# background image
###################################################


url='http://www.bing.com'
string="$(curl -s "$url" | egrep -io '"background-image:.{0,1}url\(.*\.jpg\)' | egrep -o '\(.*\)' | sed 's/[(^\()(\)$)]//g')"
filename=$(sed -E 's/.*=(.+)&.*/\1/' <<< "$string")

[[ -f "$filename" ]] && { echo "File '$filename' already exists" >&2; exit; }
wget -q "${url}${string}" -O "$filename"
