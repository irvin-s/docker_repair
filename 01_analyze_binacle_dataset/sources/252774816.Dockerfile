FROM ubuntu:15.04  
MAINTAINER Baptiste Mathus <batmat@batmat.net>  
  
RUN apt-get update -y && \  
apt-get install libav-tools -y  
  
ADD rotate-video.sh /rotate-video  
  
RUN mkdir /photos  
WORKDIR /photos  
  
ENTRYPOINT ["/rotate-video"]  

