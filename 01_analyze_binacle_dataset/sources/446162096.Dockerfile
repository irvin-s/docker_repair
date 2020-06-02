# Python plus Git
#
# BUILDAS sudo docker build -t nlothian/python-git .
#
# VERSION 0.1
#


# Ubuntu 12.04
FROM nlothian/python
MAINTAINER Nick Lothian nick.lothian@gmail.com

# GIT
RUN apt-get -y install git

