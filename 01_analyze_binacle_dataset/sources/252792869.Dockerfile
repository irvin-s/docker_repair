# Base Env - a base environment built on the Debian 8.5 image that includes  
# curl, ruby, unzip and Java 7  
FROM debian:8.5  
MAINTAINER Daniel Maple <danielm@ibcos.co.uk>  
  
# Install the curl, java, ruby and unzip packages  
RUN apt-get update && apt-get install -y \  
curl \  
openjdk-7-jre \  
ruby \  
unzip  

