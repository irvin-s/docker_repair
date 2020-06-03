FROM google/debian:wheezy
ARG NODE_MAJOR_VERSION=6

MAINTAINER Sergej Jevsejev <sjevsejev@gmail.com>

RUN apt-get update && \
    apt-get install -y git ssh-client curl adduser build-essential && \

    # adding user which is used for volumes
    adduser 1000 --force-badname && \

    # Installing node
    curl -sL https://deb.nodesource.com/setup_${NODE_MAJOR_VERSION}.x | bash - && \
    apt-get install -y nodejs && \

    apt-get purge -y curl adduser && \

    echo "export LC_ALL=en_US.UTF-8" >> /home/1000/.bashrc && \
    echo "export LANG=en_US.UTF-8" >> /home/1000/.bashrc && \
    echo "export LANGUAGE=en_US.UTF-8" >> /home/1000/.bashrc && \

    # when removing adduser it removes ssh-client o_O
    apt-get install -y ssh-client && \

    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /src

USER 1000
