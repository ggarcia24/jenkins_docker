#! /bin/bash

if [[ -f .config ]]; then
    source .config
else
    JENKINS_HOME=$(PWD)/jenkins_home
fi

docker build -t ggarcia24/jenkins .

if [[ ! -d $JENKINS_HOME ]]; then
    mkdir $JENKINS_HOME
    chown 1000:1000 $JENKINS_HOME
fi

docker run -d \
    --name=jenkins-docker\
    --publish 8080:8080 \
    --publish 50000:50000 \
    --mount source=$JENKINS_HOME,destination=/var/jenkins_home \
    ggarcia24/jenkins
