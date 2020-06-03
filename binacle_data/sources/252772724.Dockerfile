FROM circleci/openjdk:8-jdk  
RUN sudo apt-get -y install python-dev python-pip  
RUN sudo pip install awscli --upgrade  

