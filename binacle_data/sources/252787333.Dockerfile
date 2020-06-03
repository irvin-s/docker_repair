# Spoke Dockerfile for an attic server  
FROM radial/spoke-base:latest  
MAINTAINER Brice Waegeneire, "https://bricewge.fr"  
# Install attic  
ENV DEBIAN_FRONTEND noninteractive  
RUN apt-get -q update && apt-get -qyV install \  
python3-pip \  
python3-openssl \  
libssl-dev \  
libacl1-dev &&\  
apt-get clean  
RUN pip3 install attic  
  
# Configure attic user  
RUN groupadd -g 502 attic &&\  
useradd -g attic -u 502 -s /bin/bash -d /data/ attic &&\  
passwd -d -u attic  
  
# Set the program group to be start by supervisor  
ENV SPOKE_NAME attic  
  
  

