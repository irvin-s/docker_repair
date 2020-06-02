FROM openjdk:8-jdk  
MAINTAINER Christian Kohlstedde <christian@kohlsted.de>  
RUN apt-get update && \  
apt-get -y upgrade && \  
apt-get -y install openjfx && \  
apt-get clean && \  
rm -rf /var/lib/apt/lists/*  

