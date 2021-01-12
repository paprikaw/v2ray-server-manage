#!/bin/bash
    ssh -t $REMOTE_SSH "export DEBIAN_FRONTEND=noninteractive; sudo apt-get -yq update; sudo apt-get -yq install socat; sudo apt-get -yq install rsync"
    rsync -Pz v2ray-server-autoconfigure.sh $REMOTE_SSH:/home/admin
    ssh -t $REMOTE_SSH sudo ./v2ray-server-autoconfigure.sh $DOMAIN