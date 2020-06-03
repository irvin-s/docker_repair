FROM node:alpine  
  
WORKDIR /src  
COPY . /src  
  
RUN npm i  
  
EXPOSE 80  
CMD ["node", "index.js"]  

