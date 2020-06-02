FROM node:8-alpine  
RUN apk add --no-cache tini  
RUN npm install -g p3x-redis-commander  
EXPOSE 8081  
ENTRYPOINT ['tini', '--']  
CMD p3x-redis-commander --redis redis://redis  

