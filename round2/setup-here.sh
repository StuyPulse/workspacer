comp=localhost
ssh ${comp} "rm -rf /var/tmp/robo; rm -rf /var/tmp/robo-libs"
scp -r ~/client2 ${comp}:/var/tmp/robo
scp -r ~/workspace-libs ${comp}:/var/tmp/robo-libs
ssh ${comp} "chmod -R go+r /var/tmp/robo/.ssh && cp /var/tmp/robo/setmeup.sh /var/tmp/setmeup"
