FROM node:carbon  
  
MAINTAINER Michael Williams <michael.williams@enspiral.com>  
  
WORKDIR /usr/src/app  
  
COPY package*.json ./  
RUN npm install  
COPY . .  
  
USER node  
RUN mkdir /home/node/.ssb  
VOLUME ["/home/node/.ssb"]  
  
EXPOSE 8901  
ENTRYPOINT [ "/usr/src/app/bin.js" ]  

