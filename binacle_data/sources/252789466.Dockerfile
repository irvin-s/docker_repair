FROM python:2-onbuild  
RUN apt-get update  
RUN apt-get install sudo  
RUN curl -sL https://deb.nodesource.com/setup_7.x | sudo -E bash -  
RUN sudo apt-get install -y nodejs  
RUN sudo apt-get install -y build-essential  
  
RUN npm install  

