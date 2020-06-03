FROM ubuntu:15.10  
MAINTAINER Jon Lancelle <bassoman@gmail.com>  
  
RUN apt-get update && apt-get install -y \  
curl \  
unzip \  
wget  
  
RUN apt-get install -y openjdk-8-jdk  
#ENV JAVA_HOME /opt/jdk1.8.0_65  
#ENV PATH $JAVA_HOME/bin:$PATH  

