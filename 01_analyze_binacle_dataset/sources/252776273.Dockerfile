FROM bolasblack/gentoo-nodejs:latest  
MAINTAINER c4605 <bolasblack@gmail.com>  
  
RUN emerge dev-vcs/git  
WORKDIR /root  
RUN git clone https://github.com/bolasblack/hubot-deploy.git  
WORKDIR /root/hubot-deploy  
RUN npm install --python=python2.7  

