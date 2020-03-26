FROM ubuntu:12.04  
RUN apt-get update && apt-get -y upgrade  
RUN apt-get -y install ruby bash git python-dev python-pip  
RUN chsh root -s /bin/bash  
RUN pip install awsebcli  
RUN mkdir -p /root/.ssh  
RUN mkdir /app  
WORKDIR /app  

