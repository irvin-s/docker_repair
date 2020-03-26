FROM ubuntu:16.04  
  
MAINTAINER Bjarni Jens Kristinsson <bjarni.jens@gmail.com>  
  
RUN apt-get -y update && \  
apt-get -y full-upgrade && \  
apt-get -y install git python-pip && \  
pip install --upgrade pip && \  
rm -rf /var/lib/apt/lists/*  
  
COPY requirements.txt requirements.txt  
RUN pip install -r requirements.txt  

