FROM node:latest  
MAINTAINER cowpanda<ynw506@gmail.com>  
  
RUN npm install -g pm2@latest && npm install --silent --save-dev -g typescript  
  
VOLUME ["/app"]  
WORKDIR /app  
  
ADD start /start  
RUN chmod 755 /start  
CMD ["/start"]  
  
EXPOSE 80 443  

