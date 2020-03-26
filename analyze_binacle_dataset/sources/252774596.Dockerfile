FROM node:10  
EXPOSE 2525  
EXPOSE 8080  
WORKDIR /opt/mountebank-ok  
  
COPY mountebank-ok-imposter.json ./  
  
RUN npm install -g mountebank@1.14.0  
  
CMD [ "mb", "--configfile", "mountebank-ok-imposter.json" ]  
  

