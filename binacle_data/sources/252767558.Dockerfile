FROM ubuntu:latest  
MAINTAINER Woo <abyungeun@gmail.com>  
  
RUN apt-get update  
RUN apt-get install -y software-properties-common  
RUN apt-get install -y net-tools  
RUN apt-get install -y vim  
  
RUN apt-get install -y git  
  
RUN add-apt-repository ppa:openjdk-r/ppa  
RUN apt-get update  
  
RUN apt-get install -y openjdk-8-jdk  
RUN apt-get install -y tomcat8  
  
RUN apt-get install -y apache2  
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf  

