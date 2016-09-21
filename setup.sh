#!/bin/bash
pushd `dirname "$0"` > /dev/null
SCRIPTPATH=$(pwd)
popd > /dev/null

set -eu

function try_link()
{
    file_=$1
    dst_=$2
    if [[ -L $dst_ && "$(readlink $dst_) == $dst_)" ]]; then
        echo "symlink for $file_ already exists"
        return 0
    fi
    if [[ -e $dst_ || -L $dst_ ]]; then
        yn=''
        while [[ "$yn" != 'y' && "$yn" != 'n' ]]; do
            echo "File $dst_ already exists.  Overwrite?"
            read -n 1 -p '> ' yn < /dev/tty
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
    src=$SCRIPTPATH/$file
    if [[ -L "$dst" && ! "$dst" -ef "$src" ]]; then
        echo "Error - different symlink exists at $dst.  Resolve and re-run setup.sh"
        exit 1
    fi

    if [[ -d $src ]]; then
        if [[ -L "$dst" && "$dst" -ef "$src" ]]; then
            # this happens if you already symlinked these directories to $HOME, which creates problems
            echo "Error: symlink link already exists and points to this path"
            echo "src: $src"
            echo "dst: $dst"
            exit 1
        fi
        mkdir -p $dst
        (
        shopt -s dotglob
        for file2 in $src/*; do
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

echo "Done."
echo "Remember to also symlink .vimrc from the separate 'dot vim' repository"
