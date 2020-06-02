FROM ubuntu:vivid  
  
MAINTAINER Cameron Stitt <cameron@cam.st>  
  
RUN apt-get update -y  
  
RUN apt-get install -y software-properties-common  
RUN apt-get install -y python-software-properties  
RUN apt-add-repository ppa:fkrull/deadsnakes  
RUN apt-get update -y  
  
RUN apt-get install -y python3.4  
RUN apt-get install -y python3.4-dev  
RUN apt-get install -y python3-pip  

