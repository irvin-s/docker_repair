FROM ubuntu:14.10  
MAINTAINER Guillaume J. Charmes <guillaume@charmes.net>  
  
RUN apt-get update  
RUN apt-get install -y python-pip  
RUN pip install zk-shell  

