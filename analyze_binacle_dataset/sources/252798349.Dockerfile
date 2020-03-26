#######################################################  
# This dockerfile builds a java environment #  
# #  
# #  
# Author: Demon Tsai #  
# Repository: demontsai/java:jdk7 #  
# Version: 1.0 #  
# #  
#######################################################  
  
FROM demontsai/ubuntu64:14.04  
  
MAINTAINER Demon Tsai demontsai@estinet.com  
  
  
##### Java Environment  
ENV JAVA_VERSION 7  
ENV JAVA_HOME /usr/lib/jvm/java-$JAVA_VERSION-openjdk-amd64/jre  
  
##### Update system and install apps  
RUN apt-get -qq update  
RUN apt-get -qqy install openjdk-$JAVA_VERSION-jdk  
  
##### Clean  
RUN apt-get clean  
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  

