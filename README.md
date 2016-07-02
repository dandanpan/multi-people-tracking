# Footstep WSN Pi Overlay

A set of scripts for deploying services on Raspberry Pis for the Footstep WSN.

## Installation

1. Expand SD file system. ```sudo raspi-config``` and select `Expand Filesystem`. It'll run, select `Finish` and then reboot later.
2. Create the Footstep project directory: ```mkdir -p Footstep/config```
3. Change to that directory: ```cd Footstep/config```
4. Clone this repository: ```git clone https://github.com/ccceeefff/footstep-wsn-pi.git``` (Enter github username and password)
5. Run ```/bin/bash install.sh```

## Repository Structure

* **scripts/** - set of scripts for services to run
* **services/** - services to install into init.d
* **logs/** - logs will be outputted to this directory
* **install.sh** - main install script

## Dependencies

1. Python
2. python-firebase
3. node.js / npm
4. pm2
5. mqtt client

## Tools

1. vim
2. ssh

## Definition Requirements

1. Node ID
2. Reverse SSH Port
3. Firebase API URL
4. MQTT Server
5. ssh Gateway (URL, account name, .pem)
6. Submission API
