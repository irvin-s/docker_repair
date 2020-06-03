FROM node:alpine  
  
WORKDIR /src  
COPY . /src  
  
RUN npm i --only=production  
  
EXPOSE 80  
CMD ["npm", "start"]

