#for i in {1..3}; do
    #ssh cslab1-${i}.stuycs.org "mkdir /var/tmp/workspacer"
    #scp -r * cslab1-${i}.stuycs.org:/var/tmp/workspacer
    #ssh cslab1-${i}.stuycs.org "chmod +t /var/tmp/workspacer/their-work && chmod a+xs /var/tmp/workspacer/launch.o"
#done

ssh lisa.stuy.edu "mkdir /var/tmp/workspacer"
scp -r * lisa.stuy.edu:/var/tmp/workspacer
ssh lisa.stuy.edu "chmod +t /var/tmp/workspacer/their-work && chmod a+xs /var/tmp/workspacer/launch.o"
