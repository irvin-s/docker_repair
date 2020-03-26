FROM node:boron  
  
RUN mkdir /var/www -p  
ADD dist /var/www/  
RUN cd /var/www/ && \  
npm install  
  
WORKDIR /var/www/  
  
EXPOSE 3000  
CMD node server.js

