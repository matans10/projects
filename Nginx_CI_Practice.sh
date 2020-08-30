#!/bin/bash

sudo mkdir /home/ubuntu/jenkins/nginx/$V 
sudo cp /home/ubuntu/jenkins/nginx/index.html /home/ubuntu/jenkins/nginx/$V/

if [ $menu == "1" ] ; then

    sudo docker build -t matan_$V /home/ubuntu/jenkins/nginx/
    sudo docker run -d -p :80 -v /home/ubuntu/jenkins/nginx/$V:/usr/share/nginx/html matan_$V 
    IP=`ip addr | grep inet | awk 'NR==3' | cut -d "/" -f1 | cut -d " " -f6`
    PORT=`sudo docker ps -a | awk 'NR==2' | cut -d ":" -f2 | cut -d "-" -f1`
    STATUS=$(curl -s -o /dev/null -w '%{http_code}' $IP:$PORT)
    if [ $STATUS -eq 200 ] ; then
        echo "Got 200! All done!"
        
        ##########
        #echo "pushed to DockerHUB"
        sudo docker logout
        sudo docker login --username=_________ --password=_________
        sudo docker tag matan_$V USERNAME/nginx:$V
        sudo docker push USERNAME/nginx:$V
        ##########
    
    else
        echo "Got $STATUS :( Not done yet..."
    fi
else
    echo "invalid input"

fi
