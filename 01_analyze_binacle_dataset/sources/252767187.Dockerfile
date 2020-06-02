FROM ubuntu:latest  
MAINTAINER Alexander Rogalsky <alexander.rogalsky@yandex.ru>  
LABEL Description="NodeJS Container"  
RUN (apt-get update) && (apt-get upgrade -y) \  
&& apt-get install -y build-essential \  
&& apt-get install -y curl \  
&& (curl -sL https://deb.nodesource.com/setup_5.x | bash -) \  
&& apt-get install -y nodejs \  
&& mkdir -p /opt/nodejs  
VOLUME /opt/nodejs  
  

