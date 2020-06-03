FROM debian:jessie  
MAINTAINER allan.simon@supinfo.com  
ENV DEBIAN_FRONTEND=noninteractive  
ENV LANG=C.UTF-8  
  
RUN apt-get update && \  
apt-get upgrade -y && \  
apt-get install -y rsyslog curl && \  
apt-get install -y \  
python \  
python-setuptools \  
python3 \  
python3-venv \  
python3-pip \  
aptitude \  
git-core \  
build-essential \  
libyaml-dev \  
python-dev \  
python3-dev \  
libffi-dev \  
libssl-dev && \  
easy_install pip && \  
pip install --upgrade setuptools && \  
pip install ansible && \  
pip install tox  

