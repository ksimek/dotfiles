#!/bin/bash
pushd `dirname "$0"` > /dev/null
SCRIPTPATH=$(pwd)
popd > /dev/null

set -eux

function try_link()
{
    file_=$1
    dst_=$2
    if [[ -e $dst_ || -L $dst_ ]]; then
        yn=''
        while [[ "$yn" != 'y' && "$yn" != 'n' ]]; do
            echo "File $dst_ already exists.  Overwrite?"
            read -N 1 -p '> ' yn < /dev/tty
            echo ''
        done
        if [[ "$yn" == 'y' ]]; then
            rm $dst_
            ln -s $file_ $dst_
        fi
    else
        ln -s $file_ $dst_
    fi
}

cat to_link.txt | while read file; do
    dst=~/$file
    if [[ -d $SCRIPTPATH/$file ]]; then
        mkdir -p $dst
        (
        shopt -s dotglob
        for file2 in $SCRIPTPATH/$file/*; do
            dst2=~/$file/$(basename $file2)
            try_link $file2 $dst2
        done
        )
    else
        try_link $(pwd)/$file $dst
    fi
done 

mkdir -p ~/bin
for file in ~/.scripts/*; do
    dst=~/bin/$(basename $file)
    try_link $file $dst
done
