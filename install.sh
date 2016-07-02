#!/bin/bash

# Installer script
# Let's start by installing dependencies

# start from clean repository
git checkout .

# make sure packages are upto date
sudo apt-get update

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


# install wifi configuration
# copy interfaces file
sudo cp "scripts/wificonf/interfaces" "/etc/network/interfaces"

# update and write wpa_supplicant
echo "Enter andrew id for CMU-SECURE:"
read ANDREW_ID

echo "Enter andrew password for CMU-SECURE"
read ANDREW_PASS

# append CMU-SECURE block to wpa_supplicant
echo "network={
    ssid=\"CMU-SECURE\"
    scan_ssid=1
    key_mgmt=WPA-EAP
    pairwise=CCMP TKIP
    group=CCMP TKIP
    eap=PEAP
    identity=\"$ANDREW_ID\"
    password=\"$ANDREW_PASS\"
    phase1=\"peapver=0\"
    phase2=\"MSCHAPV2\"
}" >> "scripts/wificonf/wpa_supplicant.conf"

# copy wpa_supplicant to appropriate folder
sudo cp "scripts/wificonf/wpa_supplicant.conf"  "/etc/wpa_supplicant/wpa_supplicant.conf"

# restart wlan0 interface
sudo ifdown wlan0 && sudo ifup wlan0;

# go into scripts module and initialize
cd scripts/heartbeat;
npm install
cd -;
# start service (force restart)
pm2 start scripts/heartbeat/heartbeat.js -f


# start pm2 on boot with user pi
sudo env PATH=$PATH:/usr/local/bin pm2 startup -u pi
