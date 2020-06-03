FROM ubuntu:16.04

MAINTAINER Jeremy Likness <jeremy@jeremylikness.com>

# Set up a Node environment with the Angular CLI to build a 
# production-ready Angular image with ahead-of-time compilation

# switch to Bash 
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Grab some pre-requisites and install the 6.x version of Node
RUN apt-get update \
    && apt-get -y install build-essential \
    && apt-get -y install curl \
    && curl -sL https://deb.nodesource.com/setup_6.x | bash - \
    && apt-get -y install nodejs
    
# install the Angular CLI version
RUN npm i -g angular-cli@1.0.0-beta.24

# make the directory and copy over the files 
RUN mkdir -p /src 
COPY . /src 

WORKDIR /src 

# build and expose the result 
RUN npm i 
RUN ng build --prod --aot 