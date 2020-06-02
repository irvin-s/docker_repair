FROM ubuntu:15.10  
MAINTAINER Jon Lancelle <bassoman@gmail.com>  
  
RUN apt-get update && apt-get install -y \  
curl \  
unzip \  
wget  
  
ENV DEBIAN_FRONTEND noninteractive  
  
RUN apt-get update \  
&& apt-get install -y python-software-properties python \  
&& apt-get clean  
  
RUN apt-get update \  
&& apt-get install -y g++ make git \  
&& apt-get clean  
  
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -  
RUN apt-get install -y nodejs && apt-get clean  

