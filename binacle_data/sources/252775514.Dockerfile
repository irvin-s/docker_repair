FROM ubuntu:trusty  
MAINTAINER Ben Arnold <ben@benarnold.de>  
  
ENV DEBIAN_FRONTEND noninteractive  
  
RUN \  
apt-get install software-properties-common -y ;\  
apt-add-repository ppa:mosquitto-dev/mosquitto-ppa ;\  
apt-get update ;\  
apt-get upgrade -y ;\  
apt-get install mosquitto -y  
  
  
EXPOSE 1883  
ENTRYPOINT ["mosquitto"]  

