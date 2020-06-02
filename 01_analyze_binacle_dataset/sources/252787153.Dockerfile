FROM node:latest  
COPY proxy.js /proxy.js  
RUN npm install redbird  
ENTRYPOINT node proxy.js  

