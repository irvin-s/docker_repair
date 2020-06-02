# DOCKER-VERSION 1.3.2  
FROM ubuntu:14.04  
MAINTAINER Awesinine  
  
ENV BOTDIR /opt/bot  
  
RUN apt-get update && \  
apt-get install -y wget && \  
wget -q -O - https://deb.nodesource.com/setup | sudo bash - && \  
apt-get install -y git build-essential nodejs && \  
rm -rf /var/lib/apt/lists/* && \  
git clone \--depth=1 https://github.com/awesinine/helper.git ${BOTDIR}  
  
WORKDIR ${BOTDIR}  
  
RUN npm install  

