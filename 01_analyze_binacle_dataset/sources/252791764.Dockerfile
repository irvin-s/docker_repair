FROM golang:1.9.2-stretch  
MAINTAINER Damien Fontaine <damien.fontaine@lineolia.net>  
  
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -  
  
RUN apt-get update && apt-get install -y \  
npm \  
nodejs \  
libfreetype6 \  
libfontconfig  

