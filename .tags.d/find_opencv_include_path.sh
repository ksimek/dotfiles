#!/bin/bash


	paths=('/usr/local/Cellar/opencv3/3.1.0_3/include/' '/usr/include/opencv2') 

    for path in ${paths[@]}; do
        if [[ -e $path ]]; then
            echo $path
            exit 0
        fi
    done
    exit 1
