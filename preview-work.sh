#!/bin/bash

# Mostly untested in full, as of 2017-11-19

machinenum=$1

if [[ -z "$machinenum" || $machinenum -eq "-h" || $machinenum -eq "--help" ]]; then
    echo "Usage: . preview-work.sh <unpadded machine number>"
    echo ""
    echo "E.g.:  . preview-work.sh 14"
    echo "will access the acount at cslab4-14"
    echo ""
    echo "preview-work.sh can be invoked with `bash`, or can be `source`d"
    echo "(`.` is short for `source`). If `source`d, it will leave you in"
    echo "the directory with the student's work."
    exit 1
fi

mkdir -p ~/robo-work-previews

cd ~/robo-work-previews

" SSH into $machinenum to copy the user's work
# BEGIN SSH COMMAND ########################################
ssh cslab4-$machinenum $'
home=$(cat /var/tmp/robo-user-homedir)
if [[ -d "$home" ]]; then
    cd "$home"
    tar cf - workspace
else
    exit 1
fi' | tar xf -
# END SSH COMMAND ##########################################

mv workspace "$home"

echo "~/robo-work-previews/$home"

cd "$home" # For convenience when executed with `source`
