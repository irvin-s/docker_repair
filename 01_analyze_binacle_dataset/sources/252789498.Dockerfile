FROM node:carbon  
  
MAINTAINER Dao Anh Dung <dung13890@gmail.com>  
  
ENV TERM xterm  
  
RUN npm install -g \  
vue-cli \  
bower  
  
CMD ["node"]  
  
WORKDIR /var/www/app  

