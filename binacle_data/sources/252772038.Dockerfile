FROM node:9.11-alpine  
LABEL version="1.0.0"  
LABEL greenlight.version="1.0.0"  
LABEL greenlight.name="greenlight/demo"  
LABEL greenlight.description="demo plugin"  
  
COPY index.js /app/  
COPY package.json /app/  
COPY package-lock.json /app/  
  
WORKDIR /app/  
RUN npm install --production  
  
ENTRYPOINT ["/app/index.js"]  

