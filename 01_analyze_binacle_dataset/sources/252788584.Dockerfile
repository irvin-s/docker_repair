FROM node:5  
COPY ./ /application/  
WORKDIR /application  
  
RUN npm install  
  
EXPOSE 8090  
CMD ["npm", "start"]  
  

