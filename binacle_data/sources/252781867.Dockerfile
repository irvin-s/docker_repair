FROM mhart/alpine-node  
  
RUN mkdir /app  
  
COPY package.json /app/  
  
WORKDIR /app  
  
RUN npm install --production  
  
COPY . /app  
  
EXPOSE 8080  
CMD ["npm", "start"]  

