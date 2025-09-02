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

set -eu

cd $SCRIPTPATH

# Set up '.include_paths.txt' hints file.
# It is used to set up vim's path variable and neomake's cpp linter.
echo "Searching..."
(
    to_search=('library' 'apps' '3rd-party' 'cmake/cpp/3rd-party' 'product')
    for dir in "${to_search[@]}"; do
    (
         echo $dir
#        find $dir | grep -ie '/include$' -e 'include_private$' -e '/include_enabled$' -e '/include_detail$'
        # experimental -- add every path that whose `basename` contains "include" and doesn't contain a dot (so hopefully it's a directory)
        find $dir | grep -e '/[^/.]*include[^/.]*$' 
    )
    done
) > .include_paths.txt

if [[ -e "$SCRIPTPATH/.include_paths_exclude.txt" ]]; then
    echo "Excluding..."
    sort .include_paths.txt > /tmp/include_paths.txt
    sort "$SCRIPTPATH/.include_paths_exclude.txt" > /tmp/include_paths_exclude.txt
    comm -2 -3 /tmp/include_paths.txt /tmp/include_paths_exclude.txt  > .include_paths.txt
    rm /tmp/include_paths.txt
fi

# Set up '.alternate_paths.txt'  hints files.
# It is used by vim's `a.vim` plugin to find headers related to .cpp file.
echo "Setting up alternative paths..."
cat .include_paths.txt | while read path; do
    # TODO: current implementation is pretty crappy; assumes no subdirectories under src or include
    # Refactor using this logic:
    #1 find source directory
    #2 for each header subdirectory
        # if corresponding source subdirectory exists
            # add .alternate_paths file for header and src subdirectory, storying the other

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

if [[ -f .include_paths_generated.txt ]]; then
    echo "Adding generated paths..."
    cat .include_paths_generated.txt >> .include_paths.txt
fi

if [[ -f .include_paths_other.txt ]]; then
    echo "Adding manual paths..."
    cat .include_paths_other.txt >> .include_paths.txt
fi
