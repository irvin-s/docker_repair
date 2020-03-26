FROM node:9-alpine  
  
WORKDIR /home/app  
  
COPY . /home/app  
  
RUN npm install  
  
ENTRYPOINT ["node"]  
  
CMD ["index.js"]  
  

