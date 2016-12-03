apidir="/home/students/2019/robotics/Downloads/docs/api"

for i in {32..0}; do
    if [[ $i -lt 10 ]]; then
	comp=149.89.161.10$i
	# For cslab1: 149.89.150.10$i
    else
	comp=149.89.161.1$i
    fi
    if [[ -z $(ssh $comp "if [[ -d /var/tmp/javase8-api ]]; then echo yes; fi") ]]; then
        scp -r $apidir $comp:/var/tmp/javase8-api
        ssh $comp "chmod -R +r /var/tmp/javase8-api && chmod +x /var/tmp/javase8-api"
    fi
done
