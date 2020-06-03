FROM ubuntu:16.04  
MAINTAINER Dennis Trautwein <grafwurstula@posteo.net>  
  
RUN apt-get update && apt-get install --yes texlive-full  
  
WORKDIR /data  
VOLUME /data  

