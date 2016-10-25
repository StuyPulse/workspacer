for i in {1..32}; do
    if [[ $i -lt 10 ]]; then
	comp=149.89.161.10$i
	# For cslab1: 149.89.150.10$i
    else
	comp=149.89.161.1$i
    fi
    ssh ${comp} "rm -rf /var/tmp/robo; rm -rf /var/tmp/robo-libs"
    scp -r ~/client2 ${comp}:/var/tmp/robo
    scp -r ~/workspace-libs ${comp}:/var/tmp/robo-libs
    ssh ${comp} "chmod -R go+r /var/tmp/robo/.ssh && cp /var/tmp/robo/setmeup.sh /var/tmp/setmeup"
done
