FROM ubuntu:13.10  
  
MAINTAINER Arnaud Chen-yen-su arnaud.chenyensu@gmail.com  
  
# make sure the package repository is up to date  
RUN apt-get update  
  
# install python3 and pip for python3  
RUN apt-get install -y python3-pip  
  
# you can then use pip with the command pip3  

