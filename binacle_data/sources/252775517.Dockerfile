FROM openjdk:8-jdk  
  
RUN apt-get update && \  
apt-get upgrade -y && \  
apt-get install -y -t jessie-backports openjfx  

