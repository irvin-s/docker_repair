FROM node:8  
MAINTAINER cowpanda  
  
RUN npm install -g pm2@latest  
  
VOLUME ["/app"]  
  
WORKDIR /app  
ADD start /start  
RUN chmod 755 /start  
CMD ["/start"]  
  
EXPOSE 80 443  

