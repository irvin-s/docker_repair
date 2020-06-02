FROM debian:jessie  
  
MAINTAINER bergalath  
  
RUN apt-get update -y && \  
apt-get install --fix-missing && \  
DEBIAN_FRONTEND=noninteractive \  
apt-get install -y \  
python python-yaml sudo git \  
curl gcc python-pip python-dev \  
libffi-dev libssl-dev && \  
apt-get -y purge python-cffi && \  
pip install --upgrade cffi && \  
pip install ansible && \  
apt-get -f -y \--auto-remove remove \  
gcc python-pip python-dev \  
libffi-dev libssl-dev && \  
apt-get clean && \  
rm -rf /var/lib/apt/lists/* /tmp/*  
  
# default command: display Ansible version  
CMD [ "ansible-playbook", "--version" ]  

