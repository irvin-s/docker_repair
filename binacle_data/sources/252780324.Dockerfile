FROM ubuntu:16.04  
RUN apt-get update  
RUN apt-get -y install build-essential python3 python3-dev python3-pip  
  
WORKDIR /app  

