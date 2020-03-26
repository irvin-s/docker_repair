FROM ubuntu:14.04  
MAINTAINER Glenn "glenntencate@gmail.com"  
RUN apt-get update -y  
RUN apt-get install -y git python-pip python-dev build-essential  
RUN git clone https://github.com/blabla1337/defdev.git  
WORKDIR /defdev  
  
RUN pip install -r requirements.txt  

