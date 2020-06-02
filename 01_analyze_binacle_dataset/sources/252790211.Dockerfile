FROM ubuntu:14.04.2  
MAINTAINER cannin  
  
# UBUNTU  
## Update Ubuntu and add extra repositories  
RUN apt-get -y install software-properties-common  
RUN apt-get -y update && apt-get -y upgrade  
  
# Install basic commands  
RUN apt-get -y install links nano  
  
# Java  
RUN apt-get -y install openjdk-7-jdk  
  
EXPOSE 8080  

