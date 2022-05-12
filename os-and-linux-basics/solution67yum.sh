#!/bin/bash

# prepare environment, install all tools
yum update -y

yum install -y gcc-c++ make
curl -sL https://rpm.nodesource.com/setup_16.x | bash -

echo "install node, npm, curl, wget, net-tools"
yum install -y nodejs curl wget net-tools
sleep 15
echo ""
echo "################"
echo ""

# read user input for log directory
echo -n "Set log directory location for the application (absolute path): "
read LOG_DIR

if [ -d $LOG_DIR ]
then
  echo "$LOG_DIR already exists"
else
  mkdir -p $LOG_DIR
  echo "A new directory $LOG_DIR has been created"
fi

# display nodeJS version
node_version=$(node --version)
echo "NodeJS version $node_version installed"

# display npm version
npm_version=$(npm --version)
echo "NPM version $npm_version installed"

echo ""
echo "################"
echo ""

# fetch NodeJS project archive from s3 bucket
wget https://node-envvars-artifact.s3.eu-west-2.amazonaws.com/bootcamp-node-envvars-project-1.0.0.tgz

# extract the project archive to ./package folder
tar zxvf ./bootcamp-node-envvars-project-1.0.0.tgz

# set all needed environment variables
export APP_ENV=dev
export DB_PWD=mysecret
export DB_USER=myuser
export LOG_DIR=$LOG_DIR

# change to package directory
cd package

# install application dependencies
npm install

# start the nodejs application in the background
node server.js &

# display that nodejs process is running
ps aux | grep node | grep -v grep

# display that nodejs is running on port 3000
netstat -ltnp | grep :3000
