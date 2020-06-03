FROM ubuntu:16.04

# Expose network ports
EXPOSE 8000

# Docker-based quirks
ENV LANG C.UTF-8
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Docker env variables
ENV USER_DIR="/root"

# System-based package isntallation
RUN apt-get update -y && apt-get install -y python3-pip python-virtualenv libpq-dev && apt-get autoremove

# Setup wait-for-it for docker-compose
ADD ./wait-for-it.sh /usr/bin/wait-for-it
RUN chmod a+x /usr/bin/wait-for-it

# Backend setup
RUN pip3 install --upgrade pip

ADD requirements /volontulo/backend/requirements
WORKDIR /volontulo/backend
RUN pip3 install -r ./requirements/dev.txt

# Add build-time directories
ADD . /volontulo/backend
WORKDIR /volontulo/backend
