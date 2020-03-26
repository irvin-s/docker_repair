# Python base image
#
# VERSION 0.1



# Ubuntu 12.04
FROM ubuntu:precise
MAINTAINER Nick Lothian nick.lothian@gmail.com


RUN apt-get update

# Setup python
RUN apt-get -y install build-essential python-dev
RUN apt-get -y install python-setuptools
RUN easy_install pip
RUN pip install setuptools --no-use-wheel --upgrade

