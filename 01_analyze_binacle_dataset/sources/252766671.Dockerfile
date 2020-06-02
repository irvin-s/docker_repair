FROM node:6.3.1  
MAINTAINER Aksels <aksels.ledins@gmail.com>  
  
ENV PM2_CONFIG ecosystem.json  
ENV PM2_WATCH false  
ENV PM2_LOG_FORMAT json  
  
RUN mkdir -p /src/front  
WORKDIR /src/front  
  
# Install app dependencies  
COPY package.json /src/front/  
  
# Bundle app source  
COPY . /src/front  
  
EXPOSE 3000  
RUN npm install pm2@2.0.x yarn -g  
RUN yarn install  

