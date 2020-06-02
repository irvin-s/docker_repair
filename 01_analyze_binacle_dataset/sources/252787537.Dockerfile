FROM node:8.9.3  
ENV APP_HOME /app  
RUN mkdir -pv $APP_HOME  
WORKDIR $APP_HOME  
  
ADD . $APP_HOME  
  
ENV NODE_ENV production  
ENV NPM_CONFIG_LOGLEVEL warn  
  
RUN npm install  

