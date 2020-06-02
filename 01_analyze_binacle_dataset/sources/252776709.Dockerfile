FROM node:8-alpine  
MAINTAINER dan.turner@cba.com.au  
  
ENV APP_DIR /home/node/app  
ENV NODE_ENV "production"  
# Copy application source to $APP_DIR.  
WORKDIR $APP_DIR  
  
RUN apk add --update --no-cache --virtual .build-deps git \  
&& git clone https://github.com/cubedro/eth-net-intelligence-api.git . \  
&& npm install --force \  
&& npm cache clean --force \  
&& apk del .build-deps \  
&& chown -R node:node ${APP_DIR}  
  
# Set default docker user to node (provided by base image).  
USER node  
  
CMD [ "npm", "start" ]  

