FROM node:onbuild  
RUN npm install -g sails npm-check-updates  
RUN npm install sails-postgresql  
  
EXPOSE 1337

