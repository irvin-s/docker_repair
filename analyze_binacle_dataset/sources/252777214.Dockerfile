FROM ceroic/kubectl-slave:latest  
MAINTAINER Ceroic <ops@ceroic.com>  
  
# Install Docker and other dependencies  
RUN \  
apt-get update && \  
apt-get install -y \  
build-essential \  
bzip2 \  
ca-certificates \  
libssl-dev \  
python-dev \  
python-setuptools && \  
easy_install pip && \  
pip install --upgrade setuptools && \  
pip install ansible apache-libcloud docker-py  

