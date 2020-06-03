FROM node:carbon  
  
MAINTAINER Michael Williams <michael.williams@enspiral.com>  
  
WORKDIR /usr/src/app  
  
COPY ./package*.json ./  
RUN npm install  
COPY . .  
  
USER node  
RUN mkdir /home/node/.ssb  
VOLUME ["/home/node/.ssb"]  
  
ENTRYPOINT [ "/usr/src/app/client/bin.js" ]  

