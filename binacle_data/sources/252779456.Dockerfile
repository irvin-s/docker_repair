FROM ubuntu:16.04  
RUN apt-get update && \  
apt-get install -y software-properties-common  
  
RUN apt-add-repository ppa:ansible/ansible && \  
apt-get update && \  
apt-get install -y python-pip ansible curl groovy && \  
pip install softlayer && \  
pip install docker-py && \  
pip install pyvmomi && \  
pip install apache-libcloud && \  
adduser --disabled-password --gecos '' ansible  
  
COPY hosts/*.py /etc/ansible/  
COPY hosts/softlayer.py /etc/ansible/hosts  
COPY hosts/gce.py /etc/ansible/hosts  
  
RUN chmod +x /etc/ansible/*.py && \  
chmod +x /etc/ansible/hosts  
  

