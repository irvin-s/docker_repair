FROM ubuntu:xenial  
  
RUN apt-get update && apt-get install -y \  
apt-transport-https \  
curl \  
flake8 \  
fabric \  
git \  
sudo  

