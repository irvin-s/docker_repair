FROM iojs:2.3.0-slim  
  
RUN mkdir /app  
WORKDIR /app  
  
ADD package.json /app/  
RUN npm install --production  
  
ADD . /app  
  
CMD ["stats.js"]  
ENTRYPOINT ["iojs"]  

