FROM node  
  
WORKDIR /app  
  
COPY package.json ./  
RUN npm install  
  
COPY . ./  
  
ENV TIMEOUT=60000  
EXPOSE 3000  
ENTRYPOINT node src/index.js  

