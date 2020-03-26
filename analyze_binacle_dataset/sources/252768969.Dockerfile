FROM node:wheezy  
  
RUN mkdir -p /usr/src/hm-chat-client  
WORKDIR /usr/src/hm-chat-client  
  
COPY ./package.json /usr/src/hm-chat-client  
RUN npm install  
COPY ./ /usr/src/hm-chat-client  
  
CMD [ "node", "index.js" ]

