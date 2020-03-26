FROM alpine:3.4  
RUN mkdir -p /usr/src/app  
WORKDIR /usr/src/app  
  
COPY package.json /usr/src/app/  
RUN apk add --update nodejs  
COPY . /usr/src/app  
RUN cd /usr/src/app; npm install  
EXPOSE 4000  
CMD [ "npm", "install"]  
CMD [ "npm", "start" ]  

