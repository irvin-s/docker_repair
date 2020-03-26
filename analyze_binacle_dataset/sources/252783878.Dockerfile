FROM node:5.2.0-slim  
MAINTAINER kaiyadavenport@gmail.com  
WORKDIR /app/auth  
COPY ./package.json /app/auth/package.json  
RUN npm install --production  
ADD . /app/auth  
ENTRYPOINT ["node", "index.js"]

