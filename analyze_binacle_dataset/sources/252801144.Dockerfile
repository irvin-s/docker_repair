FROM google/nodejs  
  
RUN mkdir /app  
ADD . /app/  
  
WORKDIR /app  
EXPOSE 8000  
CMD ["node", "server.js"]  

