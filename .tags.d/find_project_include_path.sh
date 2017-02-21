#!/bin/bash
set -eu
paths=("$@")

for path in ${paths[@]}; do
    if [[ -e $path/.include_paths.txt ]]; then
        while read include_path; do
            echo $path/$include_path
        done < $path/.include_paths.txt
        exit 0
    fi
done
exit 1
