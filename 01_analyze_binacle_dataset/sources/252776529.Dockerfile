FROM node:argon  
  
# Create app directory  
RUN mkdir -p /usr/src/app  
WORKDIR /usr/src/app  
  
# Bundle app source  
COPY . /usr/src/app  
RUN npm i -g jspm  
RUN npm run setup  
  
EXPOSE 8088  
CMD [ "cd /usr/src/app", "npm run run"]  

