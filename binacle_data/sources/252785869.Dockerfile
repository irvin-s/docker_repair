FROM ubuntu:14.04  
MAINTAINER George Niculae <george.niculae79@gmail.com>  
  
RUN apt-get install -y software-properties-common  
RUN add-apt-repository ppa:kurento/kurento  
RUN apt-get install -y wget  
RUN wget -O - http://ubuntu.kurento.org/kurento.gpg.key | apt-key add -  
RUN apt-get update  
RUN apt-get install -y kurento-media-server  
RUN apt-get install -y kms-platedetector  
  
EXPOSE 8888  
ENTRYPOINT ["/usr/bin/kurento-media-server"]  

