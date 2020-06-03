FROM node:8.9.4 as buildStage  
  
WORKDIR /app  
  
COPY . /app  
  
USER root:root  
  
RUN chown node:users /app  
  
RUN npm install -g bower  
  
RUN npm install -g polymer-cli --unsafe-perm  
  
USER node:users  
  
RUN bower install  
  
RUN polymer build  
  
COPY /data /app/build/default/data  
COPY /res /app/build/default/res  
  
#PRODUCTION STAGE  
FROM nginx:1.13.7-alpine AS productionStage  
  
COPY \--from=buildStage /app/build/default /usr/share/nginx/html  

