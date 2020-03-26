FROM node:6  
RUN mkdir /app  
WORKDIR /app  
  
COPY package.json /app  
RUN npm install  
  
COPY . /app  
  
EXPOSE 3000  
EXPOSE 27017  
CMD ["npm", "start"]  

