FROM ubuntu:latest  
  
MAINTAINER devlee <devlee@outlook.com>  
  
RUN apt-get update; \  
apt-get -y upgrade  
  
RUN apt-get -y install git nodejs  
  
RUN mkdir /home/git; \  
cd /home/git; \  
sudo git clone https://github.com/devlee/resume.git -b master  
  
WORKDIR /home/git/resume  
  
EXPOSE 8180  
CMD ["/usr/bin/nodejs","server.js"]

