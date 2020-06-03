FROM mhart/alpine-node:4.2  
RUN apk update && apk upgrade && apk add curl bash  
RUN npm install -g npm  

