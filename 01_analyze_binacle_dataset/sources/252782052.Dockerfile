FROM node:6.5.0  
# setup docker  
RUN wget -qO- https://get.docker.com/ | sh  
  
# setup maid-bot  
RUN apt-get update && apt-get install -y redis-tools  
RUN npm install -g hubot coffee-script  
  
ENV HUBOT_MAID_WORKDIR /workspace  
ENV REDIS_URL redis  
  
WORKDIR $HUBOT_MAID_WORKDIR/hubot  
  
COPY bin bin/  
COPY scripts scripts/  
COPY external-scripts.json ./  
COPY package.json ./  
COPY .babelrc ./  
  
RUN npm install  
  
CMD ["npm", "run", "start-slack"]  

