FROM node:alpine  
  
# Copy application files  
COPY . /app  
  
WORKDIR /app  
  
# Install dependencies  
RUN npm install  
  
# Run  
ENTRYPOINT [ "npm", "start" ]  

