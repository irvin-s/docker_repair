FROM node:alpine  
  
MAINTAINER "akinobu-tani" <akinobu.x.tani@gmail.com>  
  
RUN npm install -g redis-commander@0.4.3  
  
EXPOSE 8081  
CMD ["redis-commander"]

