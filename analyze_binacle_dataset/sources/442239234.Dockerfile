#
# Dockerfile that builds container with nodejs and Python
# When not using vagrant, run it manually with: docker build - < Dockerfile.nodejs
#


# Image: NodeJS & Python
#
# VERSION               0.0.1

FROM     ubuntu
MAINTAINER Jonas Colmsjö "jonas@gizur.com"


# -----------------------------------------------------------------------------------
# PREPARATIONS 
#

# sudo will complain about unknown host otherwise
RUN echo "127.0.0.1\t`hostname`" >> /etc/hosts

# make sure the package repository is up to date
RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN apt-get update -y


#
# Install some nice tools
#

RUN apt-get install -y git wget


#
# Install NodeJs
#

RUN apt-get update -y
RUN apt-get install -y python g++ make software-properties-common
RUN apt-get install -y --reinstall python-software-properties
RUN dpkg-reconfigure python-software-properties
RUN add-apt-repository -y ppa:chris-lea/node.js
RUN apt-get update -y
RUN apt-get install -y nodejs


# -----------------------------------------------------------------------------------
# Setup the app
#

# Bundle app source
ADD . /src

# Install app dependencies
RUN cd /src; npm install

EXPOSE  8080
CMD ["node", "/src/index.js"]
