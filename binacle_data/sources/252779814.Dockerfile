#  
# Dockerfile for debian with ansible installed.  
#  
# https://github.com/confirm-it-solutions/docker-debian  
#  
  
FROM debian:latest  
  
MAINTAINER confirm IT solutions, dbarton  
  
RUN \  
apt-get -y update && \  
apt-get -y install python-dev python-pip && \  
pip install ansible && \  
apt-get remove -y python-dev gcc g++ && \  
apt-get autoremove -y && \  
rm -rf /var/lib/apt/lists/* && \  
mkdir -p /etc/ansible && \  
echo localhost >/etc/ansible/hosts

