FROM node:alpine  
  
COPY . /app  
WORKDIR /app  
  
RUN npm install  
  
ENTRYPOINT ["node"]  
CMD ["index.js"]  

