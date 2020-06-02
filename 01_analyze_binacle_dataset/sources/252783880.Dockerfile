FROM node:5.2.0-slim  
MAINTAINER kaiyadavenport@gmail.com  
WORKDIR /app  
COPY ./package.json /app/package.json  
RUN npm install --production  
ADD ./src /app/src  
ENTRYPOINT ["node", "src/index.js"]

