FROM ubuntu:xenial  
  
RUN apt-get update && apt-get install -y keystone  
  
COPY files/start.sh /opt/start.sh  
RUN chmod 755 /opt/start.sh  

