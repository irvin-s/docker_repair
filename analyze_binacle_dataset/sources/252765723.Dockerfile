FROM node:8.9.4-alpine  
  
ARG NPM_REGISTRY  
  
WORKDIR /opt/domain  
  
VOLUME /opt/domain  
  
RUN apk add \--no-cache tzdata \  
&& apk add \--no-cache git \  
&& apk add \--no-cache python make g++ \  
&& npm config set registry $NPM_REGISTRY  
  
EXPOSE 9999  
  
CMD npm install && npm rebuild && npm run start

