FROM google/nodejs  
  
ADD . /app  
WORKDIR /app  
RUN npm install http-auth  
  
EXPOSE 8000  
ENV NODE_PATH /data/node_modules/  
CMD ["node", "server.js"]  

