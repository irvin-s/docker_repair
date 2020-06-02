FROM python:2-slim  
ENV DEBIAN_FRONTEND=noninteractive  
ENV ANSIBLE_VERSION=2.4.2  
RUN mkdir -p /ansible/  
WORKDIR /ansible/  
RUN pip install ansible==$ANSIBLE_VERSION  

