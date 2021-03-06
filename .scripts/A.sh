#!/bin/bash

# alternate between source and build directories

cur_dir=$(basename $(pwd));
next_path=$(pwd);

if [[ ! -z $A_old_dir ]]; then
    cd $A_old_dir
    unset A_old_dir
else
    while [[ $next_path != '/' ]]; do
        to_check=()
        next_dir=$(basename $next_path);
        if [[ $cur_dir == *-build ]]; then
            to_check+=(${next_path/%-build/})
        elif [[ $cur_dir == build* ]]; then
            to_check+=(${next_path/#build/})
        else
            to_check=($next_path/$cur_dir-build)
            to_check=($next_path/build)
        fi

        for check in "${to_check[@]}"; do
            if [[ -d "$check" ]]; then
                export A_old_dir=$(pwd)
                cd $check
                break 2
            fi
        done
        cur_dir=$next_dir
        next_path=$(dirname $next_path);
    done
fi
