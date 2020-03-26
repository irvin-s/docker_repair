FROM node:0.11-slim  
ADD . /app  
RUN cd /app && npm install  
ENTRYPOINT ["node","/app/index.js"]  

