FROM node:8.9.4-stretch  
LABEL MAINTAINER="Ivan <aoach.public@gmail.com>"  
  
WORKDIR /app  
  
RUN npm install discord-irc  
  
ENV PATH=/app/node_modules/.bin:$PATH  
  
CMD discord-irc --config ./config/*.json

