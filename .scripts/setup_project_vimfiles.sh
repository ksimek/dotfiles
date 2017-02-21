#!/bin/bash

# Set up helper files that let vim know where to find important files while working 
# under a project path.  This is customized to whatever project I'm currently working on,
# so it will likely need modification for future project.

# Usage: This script should be symlinked into the root directory of a project 
# and called any time the directory layout changes in a meaningful way.

pushd `dirname "$0"` > /dev/null
SCRIPTPATH=$(pwd)
popd > /dev/null

to_absolute()
{
    (cd "$1"; pwd)
}

cd $SCRIPTPATH

# Set up '.include_paths.txt' hints file.
# It is used to set up vim's path variable and neomake's cpp linter.
(
    to_search=('library' 'apps' '3rd-party')
    for dir in "${to_search[@]}"; do
    (
        find $dir | grep '/include$' 
    )
    done
) > .include_paths.txt

# Set up '.alternate_paths.txt'  hints files.
# It is used by vim's `a.vim` plugin to find headers related to .cpp file.
cat .include_paths.txt | while read path; do
    abs_path=$(to_absolute $path)
    cur_path=$abs_path
    while [[ "$cur_path" != $SCRIPTPATH ]]; do
        cur_path=$(dirname $cur_path)
        if [[ -d "$cur_path/src" ]]; then
            found_header=$(find $abs_path | grep '\.h$' | head -1)
            if [[ ! -z "$found_header" ]]; then
                alt_path=$(dirname $found_header)
                echo "$alt_path" > "$cur_path/src/.alternate_paths.txt"
                break
            fi
        fi
    done
done
