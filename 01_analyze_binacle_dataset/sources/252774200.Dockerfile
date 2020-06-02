FROM debian:9  
RUN apt-get update && \  
apt-get -y install python python-pip curl less jq && \  
pip --no-cache-dir install ansible awscli boto3 && \  
apt-get -y clean  
  
RUN mkdir -p /work  
  
# Copying Ansible playbook...  
WORKDIR /work  
COPY . /work  
  
# Creating inventory file...  
RUN echo localhost > inventory  

