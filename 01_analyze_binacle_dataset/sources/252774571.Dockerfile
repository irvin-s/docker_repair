# Dockerfile for openjdk java 7 JRE  
# docker pull barnybug/openjdk-7-jre  
FROM ubuntu:12.04  
MAINTAINER Barnaby Gray <barnaby@pickle.me.uk>  
  
# enable universe  
RUN sed 's/main$/main universe/' -i /etc/apt/sources.list  
RUN apt-get update  
  
RUN apt-get install -y openjdk-7-jre-headless && apt-get clean  
  
# just for testing  
ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64  
CMD java -version

