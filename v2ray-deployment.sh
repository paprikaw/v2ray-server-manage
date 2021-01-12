#!/bin/bash
while getopts ":d:" opt; do
    case ${opt} in
    :) # Sync for server side
        echo "Invalid option: $OPTARG needs an argument"
        exit 1
        ;;
    d)
        DOMAIN=$OPTARG
        ;;
    \?)
        print_usage
        echo "Invalid option: $OPTARG" #There is no match flags
        exit 1
        ;;
    esac
done
if [[ -z "${DOMAIN}" ]]; then
    exit 1
else
    ssh -t $REMOTE_SSH "sudo apt update"
    ssh -t $REMOTE_SSH "sudo apt install rsync"
    rsync -Pz v2ray-server-autoconfigure.sh $REMOTE_SSH:/home/admin
    ssh -t $REMOTE_SSH sudo ./v2ray-server-autoconfigure.sh $DOMAIN

fi
