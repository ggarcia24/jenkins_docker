FROM jenkins/jenkins:lts
MAINTAINER Gonzalo Garcia <gonzalogarcia243@gmail.com>

USER root
RUN echo "America/Argentina/Cordoba" > /etc/timezone && dpkg-reconfigure -f noninteractive tzdata
USER jenkins

COPY plugins.txt /usr/share/jenkins/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/plugins.txt

COPY executors.groovy /usr/share/jenkins/ref/init.groovy.d/executors.groovy

