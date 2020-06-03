FROM ubuntu:16.04  
MAINTAINER Aldrin Seychell <aldrin.seychell@um.edu.mt>  
  
VOLUME "/project"  
WORKDIR "/project"  
  
RUN apt-get update && \  
apt-get install vim build-essential wget openjdk-8-jdk nodejs -y && \  
apt-get clean autoclean && \  
apt-get autoremove -y  
  
# Setup JAVA_HOME, this is useful when working/compiling with java  
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/  
RUN export JAVA_HOME  
  
CMD ["bash"]  

