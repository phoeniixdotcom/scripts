#!/bin/bash

printf "================================================================================\n"
printf "= Docker Actions Script                                                        =\n"
printf "================================================================================\n"

sudo docker ps -a

while true; do
    #arr=($(sudo docker ps -q))
    #arr=($(sudo docker ps -q | awk ' {print $1} '))

    printf "\n"

    read -n1 -rsp "Do you wish to St(a)rt, St(o)p, (d)elete, show (l)ogs on a container, (r)efresh, or (q)uit:" ACTION
    
    printf "\n"

    if [ "$ACTION" == "q" ]; then
        printf "\n"
        printf "Exiting..."
        printf "\n"
        exit 0
    elif [ "$ACTION" == "a" ]; then
        printf "\n"
        read -p $"Enter the docker container you wish to start:" CONTAINER
        printf "\n"
        sudo docker start $CONTAINER
    elif [ "$ACTION" == "o" ]; then
        printf "\n"
        read -p $"Enter the docker container you wish to stop:" CONTAINER
        printf "\n"
        sudo docker stop $CONTAINER
    elif [ "$ACTION" == "d" ]; then
        printf "\n"
        read -p $'Enter the docker container you wish to delete, or (a)ll:' CONTAINER
        printf "\n"
        if ["$CONTAINER" == "a"]; then
            sudo docker rm $(docker ps -a -q) 
        else
            sudo docker rm $CONTAINER
        fi
    elif [ "$ACTION" == "l" ]; then
        printf "\n"
        read -p $"Enter the docker container you wish to see logs:" CONTAINER
        printf "\n"
        sudo docker logs $CONTAINER
    elif [ "$ACTION" == "r" ]; then
        printf "\n"
        printf "Refreshing container list..."
        printf "\n"
        sudo docker ps -a
    else
        printf "\n"
        printf "Unknown action, please try again."
        printf "\n"
    fi
done
