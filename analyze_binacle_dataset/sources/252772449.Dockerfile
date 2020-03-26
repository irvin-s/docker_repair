FROM ubuntu:14.10  
# Base install  
RUN apt-get update -y  
RUN apt-get install -y git-core \  
curl \  
wget \  
build-essential \  
python2.7 \  
python2.7-dev \  
python-pip  
  
# Install NVM  
RUN git clone https://github.com/creationix/nvm.git /.nvm  
RUN echo ". /.nvm/nvm.sh" >> /etc/bash.bashrc  

