FROM mhart/alpine-node:5.7.1  
MAINTAINER Corey Butler  
  
ADD ./lib /app  
WORKDIR /app  
  
RUN npm install  
  
CMD ["npm", "start"]  

