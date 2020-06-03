# https://nodejs.org/en/docs/guides/nodejs-docker-webapp/  
FROM node:alpine  
  
WORKDIR /usr/src/app  
  
# Install app dependencies  
# RUN apk update && apk add \  
# python3 \  
# build-essential  
# Install app dependencies  
COPY package*.json ./  
RUN npm install  
  
# Bundle app source  
COPY . /usr/src/app/  
  
# Build app  
RUN npm run build  
  
ENV HOST 0.0.0.0  
EXPOSE 3000  
CMD ["npm", "start"]  

