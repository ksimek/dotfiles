#!/bin/bash

# cdr - "cd to project root"

cur_path=$(pwd);

while [[ $cur_path != '/' ]]; do
    if [[ -e "$cur_path/.include_paths.txt" ]]; then
        break;
    fi
    cur_path=$(dirname $cur_path);
done
if [[ $cur_path == '/' ]]; then
    echo "failed to find project root" >&2
else
    pushd $cur_path
fi
