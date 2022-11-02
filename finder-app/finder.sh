#!/bin/bash

usage() { echo "    Usage: $0 [SEARCH/DIR] [SEARCH_STRING]" 1>&2; exit 1; }

if [ $1 ] && [ -d $1 ]
then
    filesdir=$1
else
    echo "-First parameter needs to be a directory where to search within these files."
    fi
if [ $2 ] && [ -n $2 ]
then
    searchstr=$2
else
    echo "-Second parameter needs to be a Search string."
fi

if [ $# -lt 2 ]
then
    usage
fi

X=$(find $filesdir -type f 2>/dev/null | wc -l)
Y=$(grep -snioR $searchstr $filesdir | wc -l)
echo "The number of files are $X and the number of matching lines are $Y"