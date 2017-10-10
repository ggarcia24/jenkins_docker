#! /bin/bash -x

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

if [[ $(docker ps --filter name=jenkins-docker --quiet) != $(docker ps --all --filter name=jenkins-docker --quiet) ]]; then
    for STALE in $(docker ps --all --filter name=jenkins-docker --quiet); do
        docker rm -f $STALE
    done
fi


docker run -d \
    --name=jenkins-docker\
    --publish 8080:8080 \
    --publish 50000:50000 \
    --volume $JENKINS_HOME:/var/jenkins_home \
    ggarcia24/jenkins
