FROM ubuntu:latest  
LABEL maintainer "Iain J. Watson <iain@ij-watson.co.uk>"  
RUN apt-get -y update && apt-get -y upgrade  
RUN apt-get -y install python python-pip  
RUN pip install --upgrade pip  
RUN pip install eve  
RUN pip install eve-auth-jwt  
  
RUN apt-get clean  

