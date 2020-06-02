FROM debian:jessie  
MAINTAINER Amit Malhotra <amalhotra@premiumbeat.com>  
RUN apt-get update && apt-get install -y \  
build-essential \  
wget \  
libssl-dev \  
libffi-dev \  
libreadline-dev \  
libbz2-dev \  
libsqlite3-dev \  
libncurses5-dev \  
python-dev  
RUN wget https://bootstrap.pypa.io/get-pip.py  
RUN python get-pip.py  
RUN pip install \--upgrade cffi && pip install crossbar  
  
RUN mkdir -p /root/.crossbar  

