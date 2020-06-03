FROM node:6-alpine  
MAINTAINER XiNGRZ "chenxingyu92@gmail.com"  
ENV APP_HOME /var/app  
RUN mkdir -p $APP_HOME  
WORKDIR $APP_HOME  
  
ADD package.json $APP_HOME  
RUN npm install  
  
ADD . $APP_HOME  
  
ENV NODE_ENV=production  
ENV PORT=80  
RUN npm run build  
  
VOLUME [ "/var/app/data" ]  
EXPOSE 80  
CMD [ "npm", "start" ]  

