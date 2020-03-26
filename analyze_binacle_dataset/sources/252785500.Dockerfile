FROM node:8-alpine  
  
COPY . /app  
WORKDIR /app  
RUN npm install -g grunt-cli && npm install && grunt  
  
EXPOSE 3000  
CMD ["/bin/sh", "/app/start.sh"]  

