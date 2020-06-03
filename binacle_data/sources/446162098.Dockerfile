# Python plus Numpy
#
# BUILDAS sudo docker build -t nlothian/python-numpy .
#
# VERSION 0.1
#


# Ubuntu 12.04
FROM nlothian/python-flask
MAINTAINER Nick Lothian nick.lothian@gmail.com


# numpy
RUN apt-get -y install python-numpy

  
