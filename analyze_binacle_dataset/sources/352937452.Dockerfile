FROM ubuntu:14.04
MAINTAINER https://github.com/cloudfoundry/mega-ci

RUN \
      apt-get update && \
      apt-get -qqy install --fix-missing \
            build-essential \
            curl \
            git \
            libreadline6 \
            libreadline6-dev \
            wget \
            runit \
            lsof \
      && \
      apt-get clean

# Create testuser
RUN mkdir -p /home/testuser && \
	groupadd -r testuser -g 433 && \
	useradd -u 431 -r -g testuser -d /home/testuser -s /usr/sbin/nologin -c "Docker image test user" testuser
