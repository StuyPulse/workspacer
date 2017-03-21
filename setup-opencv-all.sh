#!/bin/bash

opencvtar="/home/students/2019/robotics/workspacer/opencv-3.0.0.tar.gz"

targetpath="/var/tmp/opencv-3.0.0.tar.gz"
targetdir="/var/tmp/opencv-3.0.0"

for i in {32..0}; do
    if [[ $i -lt 10 ]]; then
        comp=149.89.161.10$i
        # For cslab1: 149.89.150.10$i
    else
        comp=149.89.161.1$i
    fi
    if [[ "$1" -eq all || -z $(ssh $comp "if [[ -f $targetpath ]]; then echo yes; fi") ]]; then
        scp -r "$opencvtar" "$comp:$targetpath"
        ssh "$comp" "chmod +rx $targetpath && rm -rf /var/tmp/opencv-3.0.0 && cd /var/tmp && tar xzf opencv-3.0.0.tar.gz opencv-3.0.0"
    fi
done
