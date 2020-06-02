FROM circleci/node:8.11.0  
  
RUN sudo apt-get update && sudo apt-get install -y python-pip python-dev \  
&& sudo rm -fr /var/lib/apt/list/*  
  
RUN sudo pip install --upgrade \  
pip \  
awsebcli \  
awscli

