FROM node:0.12.7  
RUN mkdir -p /usr/src/app  
WORKDIR /usr/src/app  
  
COPY package.json /usr/src/app/  
RUN npm install  
  
COPY imap2hangouts.js run.sh /usr/src/app/  
  
VOLUME ["/data"]  
  
CMD [ "./run.sh" ]  

