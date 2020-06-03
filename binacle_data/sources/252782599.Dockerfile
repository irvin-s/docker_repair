FROM ubuntu:16.04  
RUN apt-get update  
RUN apt-get install -y npm curl  
RUN npm install -g n  
RUN n 6.2.2  
RUN curl -L https://npmjs.org/install.sh | sh  

