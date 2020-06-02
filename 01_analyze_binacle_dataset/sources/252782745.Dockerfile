FROM ubuntu:14.04  
MAINTAINER David Nonne, dave@davenonne.com  
  
RUN apt-get update  
RUN apt-get -y install expect nodejs npm  
RUN ln -s /usr/bin/nodejs /usr/bin/node  
  
RUN npm install -g coffee-script  
RUN npm install -g yo generator-hubot  
  
RUN useradd -d /opt/cambot -m -s /bin/bash -U cambot  
USER cambot  
WORKDIR /opt/cambot  
  
RUN yo hubot --owner="dave@davenonne.com" \--name="Cambot" \--defaults  
  
ADD external-scripts.json /opt/cambot/  
  
RUN npm install hubot-slack --save && npm install  
RUN npm install hubot-youtube --save && npm install  
RUN npm install hubot-cheers --save && npm install  
RUN npm install hubot-beer-me --save && npm install  
RUN npm install hubot-seen --save && npm install  
RUN npm install hubot-fliptable --save && npm install  
RUN npm install hubot-darksky --save && npm install  
RUN npm install hubot-alias --save && npm install  
RUN npm install hubot-redis-brain --save && npm install  
  
CMD bin/hubot -a slack  

