FROM node:latest  
  
RUN mkdir -p /usr/src/metabot  
WORKDIR /usr/src/metabot/bot  
  
COPY . /usr/src/metabot  
RUN npm install  
  
CMD ["npm", "run", "bot"]  

