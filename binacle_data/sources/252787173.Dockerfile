FROM ubuntu:17.04  
  
WORKDIR /home  
  
RUN apt-get update && \  
apt-get upgrade -y && \  
apt-get install -y python-pip python-dev build-essential && \  
apt-get install -y vim  
  
COPY . /home/  

