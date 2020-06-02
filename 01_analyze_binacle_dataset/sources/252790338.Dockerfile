FROM node:6.7.0-slim  
  
RUN mkdir /app  
WORKDIR /app  
  
ADD package.json /app/package.json  
RUN npm install && npm ls  
RUN mv /app/node_modules /node_modules  
  
ADD . /app  
  
ENV PORT 80  
EXPOSE 80  
CMD ["node", "server.js"]  

