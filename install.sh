#!/bin/bash

# Installer script
# Let's start by installing dependencies

sudo apt-get -y --force-yes install nodejs nodejs-legacy npm
sudo npm install -g pm2

# Let's gather all the required info
echo "Enter node name:"
read NODE_NAME
if [[ -z $NODE_NAME ]]; then
  NODE_NAME="unset"
fi

# TODO: Verify port numbers
echo "Enter ssh port (>9000):"
read SSH_PORT
if [[ -z $SSH_PORT ]]; then
  RANDOM=`date +%N|sed s/...$//`
  SSH_PORT=`$RANDOM + 9000`
fi

echo "Enter interface name:"
read IFACE_NAME
if [[ -z IFACE_NAME ]]; then
  IFACE_NAME="wlan0"
fi

echo "NODE_NAME=$NODE_NAME
SSH_PORT=$SSH_PORT
IFACE_NAME=$IFACE_NAME" > './node.config'


# go into scripts module and initialize
cd scripts/heartbeat;
npm install
cd -;
# start service (force restart)
pm2 start scripts/heartbeat/heartbeat.js -f


# start pm2 on boot with user pi
sudo env PATH=$PATH:/usr/local/bin pm2 startup -u pi
