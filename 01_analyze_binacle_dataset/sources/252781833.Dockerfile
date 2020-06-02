FROM node:6-alpine  
  
RUN apk update && \  
apk add docker curl  
  
COPY package.json package.json  
RUN npm install  
COPY . .  
  
HEALTHCHECK \--interval=1m --timeout=2s \  
CMD curl -LSs http://localhost:8080 || exit 1  
  
CMD npm start

