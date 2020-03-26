FROM circleci/node:7-browsers  
  
RUN sudo apt-get -y -qq install python-pip python-dev && \  
sudo pip install awscli  

