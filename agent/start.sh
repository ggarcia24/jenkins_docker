#! /bin/bash

./build.sh

# Remove stale containers
for STALE in $(docker ps --all --filter name=jenkins-agent --quiet); do
    docker rm -f $STALE
done

docker run --rm -d \
    --name=jenkins-agent \
    ggarcia24/jenkins-agent
