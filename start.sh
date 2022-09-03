#! /bin/bash -x

CURRENT_DIR=$(pwd)

cd controller

./start.sh

cd $CURRENT_DIR

cd agent

./start.sh
