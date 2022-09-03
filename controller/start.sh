#! /bin/bash

WORKING_DIR=$(pwd)

./build.sh

# if [[ -f .env ]]; then
#     source .env
# else
#     JENKINS_HOME=$WORKING_DIR/jenkins_home
# fi

# if [[ ! -d $JENKINS_HOME ]]; then
#     mkdir $JENKINS_HOME
#     cp -r casc_configs $JENKINS_HOME
#     cp plugins.txt $JENKINS_HOME
#     chown 1000:1000 $JENKINS_HOME
# fi

# Remove stale containers
for STALE in $(docker ps --all --filter name=jenkins-docker --quiet); do
    docker rm -f $STALE
done

docker run --rm -d \
    --name=jenkins-controller \
    --publish 8080:8080 \
    --publish 50000:50000 \
    # --volume $JENKINS_HOME:/var/jenkins_home \
    ggarcia24/jenkins-controller
