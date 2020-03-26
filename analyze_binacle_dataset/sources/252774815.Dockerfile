FROM ubuntu:15.04  
MAINTAINER Baptiste Mathus <batmat@batmat.net>  
  
RUN apt-get update -y && \  
apt-get install libav-tools libjpeg-progs -y  
  
ADD process-media.sh /process-media  
  
RUN mkdir /photos  
WORKDIR /photos  
CMD ["/process-media"]  

