FROM node  
  
WORKDIR /home/saudi-fc-service  
  
ADD package.json E:/DND/onboardservices/package.json  
RUN npm install  
  
ADD . /home/saudi-fc-service  
  
EXPOSE 8090  
CMD ["node", "server.js"]

