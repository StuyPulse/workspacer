#!/bin/bash

for i in {0..32}; do
    if [[ $i -lt 10 ]]; then
        comp=149.89.161.10$i
        # For cslab1: 149.89.150.10$i
    else
        comp=149.89.161.1$i
    fi
    ssh ${comp} "rm -rf /var/tmp/robo; rm -rf /var/tmp/robo-files"
    scp -r ~/client2 ${comp}:/var/tmp/robo
    scp -r ~/round2/robo-files ${comp}:/var/tmp/robo-files
    if [[ -z $(ssh ${comp} "if [[ -d /var/tmp/robo-libs ]]; then echo yes; fi") ]]; then
        # If the directory doesn't exist, the ssh output (stdout) will be empty.
        # Create the directory if it doesn't exist
        scp -r ~/workspace-libs ${comp}:/var/tmp/robo-libs
    fi
    ssh ${comp} "cd /var/tmp/robo-libs && ln -s /var/tmp/opencv-3.0.0 opencv-3.0.0"
    ssh ${comp} "chmod -R go+r /var/tmp/robo/.ssh && cp /var/tmp/robo/setmeup.sh /var/tmp/setmeup"

    echo -e "\nCompleted computer $i of 32\n"
done
