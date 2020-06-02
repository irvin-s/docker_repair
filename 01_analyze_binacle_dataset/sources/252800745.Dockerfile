FROM ubuntu:14.04.2  
MAINTAINER Stefan Hageneder <stefan.hageneder@dorftv.at>  
ENV DEBIAN_FRONTEND noninteractive  
ENV HOME /tmp  
WORKDIR /tmp  
RUN apt-get update && apt-get install -y wget make gcc  
RUN wget http://www.udpxy.com/download/1_23/udpxy.1.0.23-9-prod.tar.gz  
RUN tar -xzvf udpxy.1.0.23-9-prod.tar.gz  
RUN cd udpxy-1.0.23-9 && make && make install  
  
CMD ["/usr/local/bin/udpxy", "-T", "-p", "4022"]  
  

