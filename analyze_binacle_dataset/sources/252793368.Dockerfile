FROM node:8.1.2  
MAINTAINER Dan <i@shanhh.com>  
  
RUN npm install -g hubot yo generator-hubot coffee-script  
  
# Working enviroment  
ENV BOTDIR /opt/data/bot  
ENV BOTUSER hubot  
  
# Install coffee-script, hubot  
RUN mkdir -p ${BOTDIR}  
  
# Create user  
RUN useradd -m ${BOTUSER}  
RUN chown -R ${BOTUSER} ${BOTDIR}  
  
# Install Hubot  
WORKDIR ${BOTDIR}  
USER ${BOTUSER}  
  
RUN yo hubot --name="Hubot" \--defaults  

