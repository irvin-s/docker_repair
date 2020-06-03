# Ubuntu 14.04 Ansible-ready docker file  
FROM ubuntu:14.04  
MAINTAINER Bruce Becker bbecker@csir.co.za  
# Get Ansible  
# Get Ansible requirements  
RUN apt-get update  
RUN apt-get -y install \  
python-simplejson \  
libpython-dev \  
python-selinux \  
python-pip \  
git \  
python-setuptools \  
libffi-dev \  
libssl-dev \  
debianutils \  
build-essential  
  
# Install Ansible  
RUN pip install paramiko PyYAML Jinja2 httplib2 six  
RUN pip install ansible  
RUN which ansible  
RUN ansible --version  

