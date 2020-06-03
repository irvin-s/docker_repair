FROM ubuntu:14.04  
MAINTAINER Sava  
  
RUN apt-get update && apt-get install -y software-properties-common wget unzip  
ENV LANG en_US.UTF-8  
RUN locale-gen $LANG  
RUN add-apt-repository ppa:openjdk-r/ppa  
RUN apt-get update && apt-get install -y openjdk-8-jre  
  
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/  
RUN export JAVA_HOME  

