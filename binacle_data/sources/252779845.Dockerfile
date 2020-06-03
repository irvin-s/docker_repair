FROM node:7-alpine  
  
RUN apk --no-cache add git  
RUN npm i --silent -g nodemon  
  
RUN mkdir -p /usr/src/app  
  
WORKDIR /usr/src/app  
  
COPY package.json /usr/src/app/package.json  
  
RUN npm i --production --silent && npm cache clean  
  
COPY . /usr/src/app  
  
CMD node app.js  
  
EXPOSE 1337

