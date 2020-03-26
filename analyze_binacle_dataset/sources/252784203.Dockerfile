FROM node:6  
WORKDIR /app  
  
ADD . /app  
  
RUN npm install  
  
EXPOSE 80  
CMD ["node", "src/index.js"]

