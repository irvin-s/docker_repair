#############################################  
# Dockerfile to run AngelHack2017 Backend  
# Based on Alpine  
#############################################  
  
FROM node:7.8-alpine  
  
MAINTAINER Jam Risser (jamrizzi)  
  
ENV MONGO_HOST=db  
ENV MONGO_PORT=27017  
ENV MONGO_DATABASE=loopback  
ENV NODE_ENV=production  
  
EXPOSE 3000  
  
WORKDIR /app/  
  
RUN apk add --no-cache \  
tini && \  
apk add --no-cache --virtual build-deps \  
git  
  
COPY ./package.json /app/  
RUN npm install  
COPY ./ /app/  
RUN apk del build-deps && \  
npm prune --production  
  
ENTRYPOINT ["/sbin/tini", "--", "node", "/app/server/server.js"]  

