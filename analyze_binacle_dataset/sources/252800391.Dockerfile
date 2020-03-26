FROM ubuntu:latest  
MAINTAINER dolby xiaowen "githubxiaowen@gmail.com"  
RUN apt-get install -y curl  
RUN curl -sL https://deb.nodesource.com/setup_5.x | sudo -E bash -  
RUN apt-get update  
RUN apt-get install -y nodejs  
RUN npm install -g bower  
RUN npm install -g mongoose  
RUN npm install -g express  

