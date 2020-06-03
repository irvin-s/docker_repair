FROM node:6.3.1  
MAINTAINER Aksels <aksels.ledins@gmail.com>  
  
ENV PM2_CONFIG ecosystem.json  
ENV PM2_WATCH false  
ENV PM2_LOG_FORMAT json  
ENV REACT_APP_RECAPTCHA_PUBLIC_KEY 6LcBjR4TAAAAAPGttYPi7wVFO0FqYE4sREWlYinE  
  
RUN mkdir -p /src/front  
WORKDIR /src/front  
  
# Install app dependencies  
COPY package.json /src/front/  
  
# Bundle app source  
COPY . /src/front  
  
EXPOSE 3000  
RUN npm install yarn -g  
RUN yarn install  
RUN yarnpkg build  
RUN yarn global add pushstate-server  

