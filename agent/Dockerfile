FROM jenkins/inbound-agent:4.11-1-jdk11
MAINTAINER Gonzalo Garcia <gonzalogarcia243@gmail.com>

ARG poetry_version=1.1.13
ARG nodejs_version=16.x
ARG serverless_version=3.19.0

ADD VERSION .

USER root
# Need to add curl first because it's not on the packages list
RUN apt-get update -y && \
    apt-get -y --no-install-recommends install curl unzip
RUN curl -fsSL https://deb.nodesource.com/setup_$nodejs_version | bash -
RUN apt-get update -y && \
    apt-get -y --no-install-recommends install nodejs \
        python3 python3-pip python3-venv python3-setuptools jq && \
    rm -rf /var/lib/apt/lists/*

# Need pip with support for pyproject.toml
RUN pip3 install --upgrade pip
RUN pip3 install poetry==$poetry_version

# You are no longer able to install awscli v2 from PIP
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install

RUN npm install -g serverless@$serverless_version typescript@latest

USER jenkins

ENV POETRY_VERSION=$poetry_version
ENV NODEJS_VERSION=$nodejs_version
ENV SERVERLESS_VERSION=$serverless_version
