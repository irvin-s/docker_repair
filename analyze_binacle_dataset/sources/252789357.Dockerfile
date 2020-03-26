FROM ubuntu:16.04  
MAINTAINER neil@grogan.ie  
  
ENV DIRPATH /data  
ENV INSTALL_PKGS nodejs npm  
  
RUN apt-get update && \  
apt-get install -y $INSTALL_PKGS && \  
/usr/bin/npm install -g gulp  
  
WORKDIR $DIRPATH  
VOLUME $DIRPATH  
  
CMD ["/usr/bin/npm install && gulp"]  

