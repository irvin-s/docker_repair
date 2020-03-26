FROM node:5  
COPY . /app  
  
WORKDIR /app  
  
ENV NODE_ENV=production  
  
RUN npm install  
  
CMD ["node /app"]  

