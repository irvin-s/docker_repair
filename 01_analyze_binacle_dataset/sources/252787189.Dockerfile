FROM node:0.12.3  
COPY server.js /app/server.js  
COPY package.json /app/package.json  
  
RUN cd /app && npm install  
  
EXPOSE 3000  
VOLUME /data  
ENV DATA_DIR=/data  
  
ENTRYPOINT node /app/server.js  

