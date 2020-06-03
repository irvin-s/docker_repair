FROM debian:latest  
FROM node:latest  
RUN mkdir -p /usr/bin/merch_credit  
WORKDIR /usr/bin/merch_credit  
COPY . /usr/bin/merch_credit  
RUN npm install  
EXPOSE 3000  
CMD [ "npm", "start" ]  

