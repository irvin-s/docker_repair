FROM ubuntu:16.04  
  
RUN apt-get update && \  
apt-get -y install curl jq && \  
apt-get clean -q  
  
ADD startup.sh /scripts/startup.sh  
  
VOLUME /scripts  

