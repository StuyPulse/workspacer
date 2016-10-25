for i in {1..3}; do
    # TODO: switch the first 3 sections of this to work for cslab4 (currently
    # this uses the kitchen)
    comp=149.89.18.$i
    ssh ${comp} "rm -rf /var/tmp/robo; rm -rf /var/tmp/robo-libs"
    scp -r ~/client2 ${comp}:/var/tmp/robo
    scp -r ~/workspace-libs ${comp}:/var/tmp/robo-libs
    ssh ${comp} "chmod -R o+r /var/tmp/robo/.ssh && cp /var/tmp/robo/setmeup.sh /var/tmp/setmeup"
done

# Consider the following, to decentralize the load:
#self=$HOSTNAME
#ssh ${comp} "rm -rf /var/tmp/robo && rm -rf /var/tmp/workspace-libs && scp -r $HOSTNAME:/var/tmp/robo /var/tmp/robo && scp -r $HOSTNAME:/var/tmp/workspace-libs /var/tmp/workspace-libs &"
