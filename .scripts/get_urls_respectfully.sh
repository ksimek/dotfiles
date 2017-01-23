#!/bin/bash
pushd `dirname "$0"` > /dev/null
SCRIPTPATH=$(pwd)
popd > /dev/null

# Usage: get_urls_respectully urls.txt outdir
#
# Download a set of urls only between the hours of 8pm and 6am.  Skips completed downloads and resumes interrupted downloads.

set -eu

is_daytime () {
    hour=$(date +%_H)
    if [[ $hour -lt 20 && $hour -gt 6 ]]; then
        echo 1
    else
        echo 0
    fi
}

source $SCRIPTPATH/common.sh

urls_file=$(to_absolute $1)
wd=$2
cd $wd

if [[ ! -e $urls_file ]]; then
    echo "urls file not found: $urls_file"
    exit 1
fi

mkdir -p in_progress
while read url; do
    basename=$(basename $url)
    if [[ -e $basename ]]; then
        echo "$basename exists, skipping..."
        continue
    fi

    echo is_daytime: $(is_daytime) 
    while [[ 0 && $(is_daytime) -eq 1 ]]; do
        echo "Still daytime. sleeping for 10m"
        echo "Current time: " $(date)
        sleep 10m
    done

    wget -c $url -O in_progress/$basename
    mv in_progress/$basename .

done < $urls_file
