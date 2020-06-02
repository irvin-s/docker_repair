FROM ubuntu:14.04  
WORKDIR /opt  
  
RUN apt-get update && apt-get install -y \  
build-essential \  
ca-certificates \  
wget \  
curl \  
unzip \  
git \  
libcurl4-gnutls-dev \  
libgnutls-dev \  
default-jre \  
default-jdk \  
r-base  
  
RUN git clone \--recursive https://github.com/AstraZeneca-NGS/VarDictJava.git  
  
RUN cd /opt/VarDictJava; ./gradlew clean installApp  

