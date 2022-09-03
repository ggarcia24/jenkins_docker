ARG JENKINS_VERSION=lts
FROM jenkins/jenkins:$JENKINS_VERSION
LABEL Maintainer="Gonzalo Garcia <gonzalogarcia243@gmail.com>"
LABEL Description="Taken from oleg-nenashev/demo-jenkins-config-as-code"

USER root
RUN apt update -y && \
    apt -y --no-install-recommends install curl wget && \
    rm -rf /var/lib/apt/lists/*
# Change timezone
ARG timezone="America/Argentina/Cordoba"
RUN echo $timezone > /etc/timezone && dpkg-reconfigure -f noninteractive tzdata

USER jenkins
# Environment vars
ENV TRY_UPGRADE_IF_NO_MARKER=true
ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false \
    -Dhudson.model.LoadStatistics.clock=1000 ${JAVA_OPTS:-}"

# Remove war directory in Jenkins Home to make sure that the instance is updated
RUN rm -Rf /var/jenkins_home/war

# Configuration-as-Code
ENV CASC_JENKINS_CONFIG=/var/jenkins_home/casc_files
COPY casc_files /var/jenkins_home/casc_files

# Plugins config
COPY plugins.txt /var/jenkins_home/
RUN jenkins-plugin-cli --plugin-file /var/jenkins_home/plugins.txt
