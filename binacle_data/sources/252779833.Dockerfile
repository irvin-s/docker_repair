FROM node:7.8.0-alpine  
  
# Create app directory  
RUN mkdir -p /usr/src/app  
WORKDIR /usr/src/app  
  
# Install app dependencies  
RUN apk update && apk upgrade && apk add git  
  
COPY . /usr/src/app/  
ONBUILD RUN npm install  
  
# Build app  
ONBUILD RUN npm run build  
  
ENV HOST 0.0.0.0  
EXPOSE 80  
# start command  
CMD [ "npm", "run", "startprod" ]  

