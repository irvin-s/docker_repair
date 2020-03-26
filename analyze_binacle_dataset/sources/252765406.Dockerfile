FROM node:alpine  
  
LABEL maintainer="https://github.com/10sr/cron-cli-js" \  
description="Nodejs Cron Command"  
  
ENV NODE_ENV=production  
  
RUN mkdir -p /usr/src/app  
WORKDIR /usr/src/app  
  
COPY package.json .  
  
RUN npm install  
  
COPY . .  
  
CMD ["node", "bin/cron", "/etc/crontab"]  

