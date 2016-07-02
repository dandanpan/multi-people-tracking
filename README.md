# Footstep WSN Pi Overlay

A set of scripts for deploying services on Raspberry Pis for the Footstep WSN.

## Installation

1. Run ```sh install.sh```
3. Expand SD file system. ```sudo raspi-config```

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
