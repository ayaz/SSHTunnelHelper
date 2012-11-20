#!/bin/bash

SSH_HOST="dev.ayaz.pk"

SSH_USER="ayaz"

## Port on remove host where SSH is listening. 
SSH_PORT="6922"

## Local port on which the tunnel will be opened.
LOCAL_PORT="8088"

SSH_CMD="ssh -D $LOCAL_PORT -fqCN -l $SSH_USER $SSH_HOST -p $SSH_PORT"

## Kill any stale tunnels running in the background.
pids=$(ps augx | grep "$SSH_CMD" | grep -v 'grep' | awk  '{print $2}')
for pid in $pids; do
    echo "Killing PID $pid"
    kill $pid
done


echo "Opening a tunnel on localhost:$LOCAL_PORT to $SSH_HOST:$SSH_PORT ..."

$SSH_CMD

if [ $? == 0 ]
then
    echo "Tunnel opened!"
else
    echo "Failed to open tunnel."
fi

