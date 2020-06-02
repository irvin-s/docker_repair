FROM node:latest  
  
MAINTAINER John Cashmore  
  
RUN apt-get -q update  
RUN apt-get -qy install git-core redis-server  
  
RUN npm install -g yo generator-hubot coffee-script  
  
RUN adduser --disabled-password --gecos "" yeoman; \  
echo "yeoman ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers  
ENV HOME /home/yeoman  
USER yeoman  
WORKDIR /home/yeoman  
  
RUN git clone https://github.com/JohnCashmore/elf-bot.git hubot  
RUN cd hubot; npm install  
  
CMD cd hubot; bin/hubot --adapter slack  

