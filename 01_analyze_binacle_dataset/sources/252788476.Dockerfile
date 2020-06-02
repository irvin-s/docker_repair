FROM debian:jessie  
FROM node:argon  
RUN mkdir -p /usr/src/pig_ears  
WORKDIR /usr/src/pig_ears  
COPY . /usr/src/pig_ears  
RUN npm install  
EXPOSE 3000  
CMD [ "node", "pig_ears.js" ]  

