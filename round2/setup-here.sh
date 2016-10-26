comp=localhost
ssh ${comp} "rm -rf /var/tmp/robo; rm -rf /var/tmp/robo-libs; rm -rf /var/tmp/robo-files"
scp -r ~/client2 ${comp}:/var/tmp/robo
scp -r ~/workspace-libs ${comp}:/var/tmp/robo-libs
scp -r ~/round2/robo-files ${comp}:/var/tmp/robo-files
ssh ${comp} "chmod -R go+r /var/tmp/robo/.ssh && cp /var/tmp/robo/setmeup.sh /var/tmp/setmeup"
