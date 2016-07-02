#!/bin/bash

# Installer script
# Let's start by installing dependencies

#apt-get -y --force-yes install nodejs nodejs-legacy
#apt-get -y --force-yes install npm

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

echo "NODE_NAME=$NODE_NAME
SSH_PORT=$SSH_PORT" > './node.config'
