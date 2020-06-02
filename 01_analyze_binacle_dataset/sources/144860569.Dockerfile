# Survana
#
# VERSION               1.0

FROM      ubuntu
MAINTAINER Victor Petrov <victor_petrov@harvard.edu>

# make sure the package repository is up to date
RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN apt-get update

RUN apt-get install -y inotify-tools openssh-server git
