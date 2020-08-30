#!/bin/bash

while (true)
do
    echo -e "menu:\n1.install docker & checks service\n2.pull images\n3.install Cestos/Nginx"
    echo -e "4.making NGInx from input\n5.dockerui\n6.making new nginx image (msKING)"
    echo -e "7.terminating all conntainer\n8.print IP of a container\n9.making dockerfile with loop\n0.EXIT"
    read option
    if [ $option == "1" ] ; then
        echo "enter the ip of the vm you want to install on:"
        read ip
            if [ $ip == `ip addr | grep inet | awk 'NR==3 {print $2}'|cut -d '/' -f1` ] ; then
                curl -fsSL https://get.docker.com -o get-docker.sh
                sleep 5
                sh get-docker.sh
            else
                pass
            fi

            if [ `service docker status | grep 'Active' | awk '{print $2}'` == 'active' ] ; then
                echo "Docker service is active"
            else
                echo "Docker service is unactive"
            fi

    elif [ $option == "2" ] ; then
        echo "enter acontainer name: "
        read container
        sudo docker pull $container 2>&1
        result = $?
        if [ result == 0 ] ; then
            echo "there isnt such a container"
        else
            echo "pulled image"
        fi

    elif [ $option == "3" ] ; then
        echo -e "which container image do you want to pull:\n1.Centos\n2.nginx"
        read image
        if [ $image == "1" ] ; then
            sudo docker pull centos
        elif [ $image == "2" ]; then
            sudo docker pull nginx
        else
            echo "---invalid input---"
        fi

    elif [ $option == "4" ] ; then
         echo "enter a sentence you want on the nginx: "
         read sent
         echo "your docker points to ~~/home/ubuntu/py/web~~"
         echo "<h1>${sent}</h1>" > /home/ubuntu/py/web/index.html
         sudo docker run -d -p 80 -v /home/ubuntu/py/web:/usr/share/nginx/html nginx

    elif [ $option == "5" ] ; then
        sudo docker run -d -p 5566:9000 abh1nav/dockerui
        if [ echo `sudo docker ps -a | awk 'NR==2' | cut -d '(' -f1 |cut -d " " -f30` -ne \"Exited\" ] ; then
            echo "dockerui is running"
        else
            echo "dockerui isnt running"
        fi

    elif [ $option == "6" ] ; then
        sudo docker run -d -p 80 nginx
        sudo docker exec -i -t `sudo docker ps -a | awk 'NR==2 {print $1}'` bash -c 'echo "matan the KING" > /usr/share/nginx/html/index.html | exit'
        sudo docker commit `sudo docker ps -a | awk 'NR==2 {print $1}'` nginx_ms_king

    elif [ $option == "7" ] ; then
        sudo docker stop $(sudo docker ps -a -q)
        sudo docker rm $(sudo docker ps -a -q)

    elif [ $option == "8" ] ; then
        echo "enter name/id of container: "
        read _container
        sudo docker inspect $_container | grep "IPAddress" | awk 'NR==2 {print $2}'|cut -d "\"" -f2

    elif [ $option == "9" ] ; then
        echo "enter the name of the new image: "
        read new_image
        sudo docker build -t $new_image /home/ubuntu/py/dockerfile

    elif [ $option == "0" ] ; then
        break

    else
        echo "--invalid input--"
    fi

done
