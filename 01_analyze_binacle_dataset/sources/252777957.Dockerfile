FROM node:8-alpine  
  
RUN npm install unity-cache-server -g && npm cache clean --force  
  
ENTRYPOINT ["unity-cache-server"]  

