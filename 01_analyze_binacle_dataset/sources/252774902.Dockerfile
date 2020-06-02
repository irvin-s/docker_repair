FROM node:6-alpine  
  
WORKDIR /app  
  
COPY . ./  
  
RUN npm install --production  
  
ENTRYPOINT ["/app/bin/swf-metrics"]  

