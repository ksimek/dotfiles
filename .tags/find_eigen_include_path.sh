#!/bin/bash


	paths=('/usr/local/include/eigen3' '/usr/include/eigen3') 

    for path in ${paths[@]}; do
        if [[ -e $path ]]; then
            echo $path
            exit 0
        fi
    done
    exit 1
