FROM node:6  
MAINTAINER v-braun <v-braun@live.de>  
  
RUN apt-get update && apt-get install -y curl  
RUN curl -sSL https://get.docker.com/ | sh  
  
RUN mkdir -p /usr/src/app  
  
WORKDIR /usr/src/app  
  
# install the app  
COPY package.json /usr/src/app/  
COPY . /usr/src/app  
  
RUN npm install  
  
EXPOSE 3000  
CMD [ "npm", "start" ]

