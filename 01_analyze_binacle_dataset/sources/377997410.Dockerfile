FROM ubuntu:12.04
MAINTAINER Jacques Fuentes

# Install prerequisites
RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN apt-get update
RUN apt-get install -y curl wget build-essential git-core vim-tiny supervisor ruby1.9.3

# Install golang
RUN apt-get install -y python-software-properties git
RUN add-apt-repository -y ppa:duh/golang
RUN apt-get update
RUN apt-get install -y golang

# Install Serf
RUN apt-get install -y unzip
RUN wget https://dl.bintray.com/mitchellh/serf/0.2.1_linux_amd64.zip -O serf.zip
RUN unzip serf.zip
RUN cp serf /usr/local/bin
RUN mkdir /etc/serf
