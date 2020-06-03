#  
# Prepares the CSGF development environment installing oracle JDK 7 on  
# Ubuntu 14.04  
#  
  
FROM ubuntu:trusty  
MAINTAINER Bruce Becker <bbecker@csir.co.za>  
  
# Install packages  
  
RUN apt-get update && \  
apt-get install -y openjdk-7-jdk openjdk-7-jre openjdk-7-jre-lib && \  
rm -rf /var/lib/apt/lists/*  
# Run tests  

