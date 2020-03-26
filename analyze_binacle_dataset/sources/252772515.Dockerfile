# VERSION 0.1.9  
# DOCKER-VERSION 1.7.1  
# DESCRIPTION: CM Base Resource Image  
# TO_BUILD: docker build -t cm/core .  
# TO_RUN: docker run cm/core cm --version  
# docker run -i -t --entrypoint /bin/bash cm/core (SSH into)  
FROM ubuntu:14.04  
ENV GEM_CM_DEV=1 GEM_CM_DIRECTORY=/opt/cm/core CM_CMD_VERSION=0.1.9  
COPY . /opt/cm/core  
WORKDIR /opt/cm/core/bootstrap  
  
RUN /bin/bash -c "./bootstrap.sh base git svn ruby cm"  

