FROM debian:jessie  
  
MAINTAINER Marko Kirves <marko.kirves@bynd.com>  
  
ENV LANG C.UTF-8  
# Install and update Debian packages for running Python apps  
RUN apt-get update -y -q && apt-get install --no-install-recommends -y \  
ca-certificates \  
git \  
libxml2-dev \  
libpcre3-dev \  
build-essential \  
make \  
gcc \  
wget \  
python2.7 \  
python2.7-dev \  
locales \  
python-pip \  
libffi-dev \  
libssl-dev \  
&& rm -rf /var/lib/apt/lists/*  
  
# Upgrade pip to latest version  
RUN pip install -U pip  

