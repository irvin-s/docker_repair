FROM ubuntu:trusty  
MAINTAINER Tomas Markauskas <tomas@dawanda.com>  
  
RUN apt-get update && \  
apt-get install -y \  
build-essential \  
curl \  
git \  
imagemagick \  
libffi-dev \  
libgdbm-dev \  
libhiredis-dev \  
libjansson-dev \  
libmagickcore-dev \  
libmagickwand-dev \  
libmysqlclient-dev \  
libncurses5-dev \  
libreadline-dev \  
libssl-dev \  
libxml2-dev \  
libxslt-dev \  
libyaml-dev \  
nodejs \  
vim \  
wget \  
zlib1g-dev  

