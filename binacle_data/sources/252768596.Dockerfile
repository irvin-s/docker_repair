FROM python:3.6-slim  
  
RUN apt-get update && apt-get install -y openssh-client  
  
RUN mkdir /root/.ssh  
ADD ssh-config /root/.ssh/config  
RUN chmod 400 /root/.ssh/config  
  
ADD assets/ /opt/resource/  
RUN chmod +x /opt/resource/*  

