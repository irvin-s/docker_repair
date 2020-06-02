FROM node:0.10-slim  
  
WORKDIR /app  
  
ADD package.json /app/package.json  
RUN npm install  
  
ADD . /app  
  
ENV PORT 80  
EXPOSE 80  
CMD ["node", "server.js"]  

