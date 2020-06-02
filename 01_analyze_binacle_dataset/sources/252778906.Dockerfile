  
#  
# VERSION 0.5  
# DOCKER-VERSION 1.9.1  
# AUTHOR: Paolo Cozzi <paolo.cozzi@ptp.it>  
# DESCRIPTION: An image python base image which isoSegmenter will run  
# TO_BUILD: docker build --rm -t bunop/isosegmenter .  
# TO_RUN: docker run -ti bunop/isosegmenter /bin/bash  
# TO_TAG: docker tag bunop/isosegmenter:latest bunop/isosegmenter:0.5  
#  
FROM python:2.7  
MAINTAINER Paolo Cozzi <paolo.cozzi@ptp.it>  
  
# Set corrent working directory  
WORKDIR /root  
  
# Install deb dependancies. Then clean packages and histories  
RUN apt-get update \  
&& apt-get install -y libgd-dev \  
libgif-dev \  
&& apt-get clean  
  
# now clone isoSegmenter project  
RUN git clone https://github.com/bunop/isoSegmenter.git /root/isoSegmenter  
  
# Setting working directory  
WORKDIR /root/isoSegmenter  
  
# setting isosegmente version  
ENV VERSION=v1.5.1  
# checking out a tagged release  
RUN git fetch && \  
git checkout $VERSION && \  
git checkout -b $VERSION  
  
# Byte compiling libraries  
RUN pip install .  
  
# Adding a volume  
RUN mkdir /data  
VOLUME /data  
  
# Setting /data as working directory  
WORKDIR /data/  
  
# executing a default command  
CMD [ "python", "/usr/local/bin/isoSegmenter.py", "--help" ]  

